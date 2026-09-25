# Implementation Plan — Migration to Native iOS (Swift + SwiftUI)

*Date: 2026-09-25 · Scope: 1:1 behavioral port of `flutter_local_db` v1.1.5+1 to a native iOS app*

**Principle:** parity first, same as the Android/Compose plan (`COMPOSE-MIGRATION-PLAN.md`). Port the *current* Flutter behavior exactly: single view-model, status-only errors, clear-and-replace seed, no new features. `REQUIREMENTS.md` offline-first items (R1–R5) stay **out of scope** until parity is verified.

---

## 1. Target stack

| Concern | Flutter today | iOS target |
|---|---|---|
| UI | Flutter Material 3 (teal seed) | SwiftUI + NavigationStack, teal accent, portrait-locked |
| State | `flutter_bloc` (single `MyAppBloc`) | Single `MyAppViewModel` (`@MainActor @Observable`, iOS 17) |
| Local DB | `isar_community` 3.3.2 | **SwiftData** (`@Model`, server id as unique attribute) — or GRDB if strict transactions matter (see D1) |
| Network | Dio 5.11.1 (30 s timeouts, response logging) | **Alamofire 5.x** (`Session` with 30 s timeouts, `EventMonitor` response logging) |
| JSON | hand-written `fromJson` | `Codable` DTOs with explicit mapping to entities |
| Async | Dart futures, `void async` handlers | Swift Concurrency (`Task`, `async/await`) |
| DI | hard-instantiated repos | simple injected initializers (no DI container — matches today) |
| Errors | `RepositoryException` wrapping all infra errors | `RepositoryException` — identical contract, UI never sees `AFError`/`DecodingError` |

**App identity:** bundle id `com.yoesuv.flutterLocalDb`, display name "Flutter Local Db", `CFBundleShortVersionString 1.1.5`, build 1 (matches pubspec `1.1.5+1` and the Flutter `ios/` host). Installing the native build replaces the Flutter app; **no data migration** — the SwiftData store starts empty and the first online launch re-seeds (identical to the app's normal seed path).

**Deployment target:** iOS 17 (needed for SwiftData + `@Observable`). The Flutter host targets 15.0, but this codebase has no legacy support burden.

**ATS:** keep `NSAppTransportSecurity → NSAllowsArbitraryLoads = true` in the new Info.plist for `http://` parity; the REQUIREMENTS R5 https switch later removes it.

**Location:** new `ios-native/` directory at the repo root (new Xcode project). The Flutter `ios/` host is not reusable.

## 2. File-by-file mapping

| Flutter source | Swift target |
|---|---|
| `lib/main.dart` | `FlutterLocalDbApp.swift` (`@main` App); portrait lock via Target → Deployment Info (iPhone, Portrait only) — no runtime try/catch needed |
| `lib/src/my_app.dart` | `RootView`: teal-tinted theme helpers (`Color.teal` accent, UINavigationBarAppearance for the bar styling); **`.preferredColorScheme(.light)` pinned on the root** — the Flutter app defines no `darkTheme`, so it is light-only, and strict parity forbids a dark appearance appearing for free |
| `lib/src/core/data/constants.dart` | `Constants.swift` (`baseURL`, `timeout: TimeInterval = 30`) |
| `lib/src/core/errors/repository_exception.dart` | `struct RepositoryException: Error { let message: String; let cause: (any Error)? }` |
| `lib/src/core/networks/network_helper.dart` | `NetworkHelper` (Alamofire `Session`: 30 s `timeoutIntervalForRequest`/`timeoutIntervalForResource`, custom `EventMonitor` for response logging) + `UserAPI` (`session.request("users")` → Decodable) |
| `lib/src/core/repositories/app_repository.dart` | `AppRepository.fetchUsers() throws -> [User]` — validates payload is an array, maps DTOs, wraps `AFError`/`DecodingError`/unexpected shape in `RepositoryException` (mirrors how Dio errors are translated today) |
| `lib/src/core/repositories/db_repository.dart` | shared `ModelContainer` created once at app start (replaces the self-healing open-future pattern) |
| `lib/src/core/repositories/db_user_repository.dart` | `DbUserRepository`: `saveData` = background `ModelContext`, `delete` all + insert all, single `save()` (see D1), `getUsers`, `getUser(id)`, `delete(user)` |
| `lib/src/core/models/user_model.dart` | `@Model final class User` (`var id: Int?`, name, username, email, phone, website; `@Relationship var address: Address?`, `company: Company?`); nested `@Model Address` (street/suite/city/zipcode, `geo: Geo?`), `Geo` (lat/lng `String?`), `Company` |
| DTO layer (new) | `UserDTO: Decodable` + `AddressDTO` + `GeoDTO` + `CompanyDTO`; **GeoDTO needs a custom `init(from:)`** — jsonplaceholder sends `lat`/`lng` as doubles, Flutter stores `.toString()`; decode "Double or String → String" to keep parity |
| `lib/src/my_app_event.dart` | ViewModel methods `initUser()`, `loadList()`, `getUser(id:)`, `deleteUser(_:)` — events collapse into calls |
| `lib/src/my_app_state.dart` | `struct MyAppState: Equatable`: four `UiStatus` enums (initial/inProgress/success/failure = Formz values), `users: [User]`, `selectedUser: User?`; `getUser` start sets `selectedUser = nil` explicitly (replaces the `_unsetUser` copyWith sentinel) |
| `lib/src/my_app_bloc.dart` | `@Observable final class MyAppViewModel` — same handler bodies, one shared published `state` |
| `lib/src/core/routes/app_route.dart` | `NavigationStack` + `navigationDestination(for: Int.self)` → `DetailView(userId:)`; row tap passes `user.id ?? 0` (parity with `DetailArgs(id: _user.id ?? 0)`) |
| `lib/src/ui/screens/splash.dart` | `SplashView`: `.task { vm.initUser() }`; status text (Initial/"Init Data Done"/"Offline Mode") from state; on terminal status, `try? await Task.sleep(1s)` → swap root to `HomeView` (root switch replaces `pushNamedAndRemoveUntil`) |
| `lib/src/ui/screens/home.dart` | `HomeView`: `.task { vm.loadList() }`; delete toast ("Delete Success"/"Delete Failed") as a lightweight overlay toast (SwiftUI has no native snackbar; `.alert` would be too intrusive); failure state Retry button; empty state "No users" |
| `lib/src/ui/widgets/item_user.dart` | `UserRow` + `.swipeActions(edge: .trailing)` red Delete → `vm.deleteUser(user)`; tap → `NavigationLink(value: user.id ?? 0)` |
| `lib/src/ui/screens/detail.dart` | `DetailView`: `.task { vm.getUser(id) }`; failure → Retry; **stale-guard is free** — `selectedUser` is nil until this screen's load completes, so show `ProgressView` until Success |
| `lib/src/ui/widgets/text_splash.dart` | inline `Text` |

**State-detail decisions (mirroring the careful bits from ANALYSIS.md):**
- D1 **DB transaction:** Isar's `writeTxn` is atomic; SwiftData has no explicit transaction API. `saveData` must run delete-all + insert-all on one background `ModelContext` and call `save()` once — the change set is persisted in one save, which is the closest equivalent. If strict atomicity is required, swap SwiftData for **GRDB** (real SQL transactions, Codable records, JSON columns for Address/Company). SwiftData is the default recommendation; decide before P2.
- D2: `User.id` nullable in Flutter, `@Attribute(.unique)` in SwiftData stays `Int?` — same semantics, deletion guard `guard let id else { throw … }` mirrors the `ArgumentError` path.
- D3: keep "any failure → Offline Mode" splash label (cosmetic mislabel accepted in ANALYSIS.md).
- D4: users written by both load and delete paths, exactly like today's monolithic state.

## 3. Phases

**P1 — Scaffold (goal: `xcodebuild -scheme FlutterLocalDb -destination 'generic/platform=iOS Simulator' build` green)**
`ios-native/` Xcode project (or Swift Package + project via XcodeGen/Tuist if preferred), app entry, portrait-locked Info.plist, ATS exemption, teal accent. Empty `HomeView` placeholder.

**P2 — Data layer**
DTOs (incl. the Geo Double-or-String decoder), `NetworkHelper` + `UserAPI`, SwiftData models + container, `AppRepository`, `DbUserRepository`, `RepositoryException`. Repositories injected as protocols so implementations can be swapped by hand — **no test code is written**: no XCTest/Swift Testing targets, no unit tests (standing constraint); verification is the P5 manual checklist only.

**P3 — ViewModel**
`UiStatus`, `MyAppState`, `MyAppViewModel` with the four operations; one-shot side effects (delete toast, splash root swap) as dedicated `@Observable` fields, not inside `MyAppState`, so they don't re-fire on view updates.

**P4 — UI**
Root splash/home switch, `HomeView` (list, empty, failure Retry, swipe-delete, toast), `DetailView` (all fields incl. Address/Company sections, spinner, Retry).

**P5 — Parity verification (manual, per no-tests constraint)**
1. Cold start online → "Init Data Done", ~1 s later Home shows list.
2. Cold start offline (seeded) → "Offline Mode" → Home shows cached list.
3. Cold start offline, never seeded → "No users".
4. Swipe-delete row → toast; offline restart → entry gone; online restart → re-seeded (clear-and-replace trade-off, expected).
5. Detail loads from DB; Retry on failure; spinner until own load completes.
6. Rotation locked to portrait; airplane-mode toggle mid-session → no crash, no auto-refresh (R4 intentionally not ported yet).
7. **Release build on a real device** — replaces the old isar_community #68 guardrail entirely: native SwiftData has no fork-related release-only load failures, so this is now a routine smoke test.
8. Dark-mode check: app stays **light in system dark mode** (parity pin above); Dynamic Type renders natively (larger text scales — a native benefit, not a layout change).

**P6 — Decommission decision**
Keep both stacks until P5 passes, then either delete Flutter code or make `ios-native/` the sole iOS artifact and keep Flutter for Android.

## 4. Dependencies

One third-party package: **Alamofire 5.x** via Swift Package Manager (mirrors the Dio role exactly — request layer, timeouts, response logging). Everything else is first-party: SwiftData for the DB, SwiftUI/NavigationStack for UI. Xcode 16+, Swift 6 language mode; Alamofire's async/await API (`AF.request(...).serializingDecodable`) hops off the main actor automatically.

Logging parity: implement one `EventMonitor` subclass (`ResponseLoggingMonitor`) that prints status code + URL + chunked body, gated by `#if DEBUG` — the equivalent of `LoggingInterceptor`.

## 5. Risks / notes

- **DB choice:** SwiftData is confirmed as the local database (first-party, iOS 17, `@Attribute(.unique)` server-id keying); GRDB remains only a documented fallback for D1 atomicity.
- **Geo lat/lng decoding** is the only non-trivial serialization difference (Double vs String) — the custom decoder in the DTO layer handles it; entity stays `String?` for display parity.
- **SwiftData atomicity** (D1) is the main technical risk; if delete-all + insert-all + single `save()` ever proves non-atomic under interruption, GRDB is the documented fallback with the same repository interface.
- **Clear-and-replace semantics** carry over unchanged — deleted users reappear after a successful refresh, same accepted trade-off.
- **No tests, no unit tests:** P5 checklist replaces them, mirroring the standing constraint — no XCTest/Swift Testing targets, no test schemes, no CI test steps; the build gate is the P1 `xcodebuild` command.
- **Compose plan symmetry:** package/naming mirrors `COMPOSE-MIGRATION-PLAN.md` so the two native apps can be maintained side by side with shared review checklists.
