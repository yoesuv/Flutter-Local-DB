# Codebase Analysis — `flutter_local_db` v1.1.5+1

*Date: 2026-09-25 · Lens: offline-first readiness*
*Evidence: first-hand source read, platform config inspection, ecosystem verification (pub.dev/GitHub APIs, fetched 2026-09-25)*

**Constraints honored (agreed in interview):** local-only handling · single `MyAppBloc` · status-only errors · no tests · mobile-only · no schema changes · stay on `isar_community`.

---

## 1. Architecture as implemented

```
Splash (initState) ──add──► MyAppInitUserEvent
                              │  AppRepository.getUser()        NetworkHelper (Dio, http://, 30s timeouts, LoggingInterceptor)
                              │    → User.buildListFromJson      (errors → RepositoryException, stack preserved)
                              ▼  DbUserRepository.saveData      (writeTxn: users.clear() + putAll — atomic full replace)
Home (initState) ────add───► MyAppLoadListUserEvent ──► DbUserRepository.getUsers()
Detail (initState) ──add───► MyAppGetUserEvent(id) ───► DbUserRepository.getUser(id)   (+ DeleteUserEvent → delete + reload)
```

- **Entry/DI**: `lib/main.dart` — portrait lock (failure-tolerant), `runApp(const MyApp())`. No DI container; `lib/src/my_app.dart` wraps the app in `MultiBlocProvider` → `BlocProvider<MyAppBloc>`; `MaterialApp` uses `onGenerateRoute: AppRoute.routes`.
- **Network**: `lib/src/core/networks/network_helper.dart` — `NetworkHelper` constructs its own `Dio` (`BaseOptions`: `BASE_URL`, 30s connect/send/receive timeouts from `lib/src/core/data/constants.dart`) with `LoggingInterceptor` (response logging only). Only a `get()` method exists.
- **Repositories**:
  - `lib/src/core/repositories/app_repository.dart` — `AppRepository.getUser()` calls `networkHelper.get('users')`, validates the payload is a `List`, maps via `User.buildListFromJson`, and translates all infra errors (DioException/FormatException/TypeError) into `RepositoryException` (`lib/src/core/errors/repository_exception.dart`) via `Error.throwWithStackTrace`. `NetworkHelper` injectable via constructor.
  - `lib/src/core/repositories/db_repository.dart` — abstract generic `DbRepository<T>`: lazy, self-healing `isarAsync` future opening `Isar.open([collectionSchema], directory: appDocumentsDir)`; on open failure the cached future resets so a later access retries. One schema per instance.
  - `lib/src/core/repositories/db_user_repository.dart` — `DbUserRepository extends DbRepository<User>(UserSchema)`: `saveData` (clear + putAll in one txn — atomic full replace, not merge), `getUsers`, `getUser(id)`, `delete(user)` (throws `ArgumentError` if `id == null`).
- **Models / Isar schema**: `lib/src/core/models/user_model.dart` (`@collection User`: id, name, username, email, address, phone, website, company; hand-written `fromJson`/`toJson` + `buildListFromJson`), embedded `Address`, `Geo` (lat/lng stored as `String` via `?.toString()`), `Company` — generated `*.g.dart` by isar_community_generator 3.3.2. `User` is the only registered collection. The Isar primary key **is the server-provided id** — no autoincrement reliance.
- **BLoC**: `lib/src/my_app_bloc.dart` — single `MyAppBloc` hard-instantiates both repositories (no injection). Handlers: `MyAppInitUserEvent` (API fetch → saveData), `MyAppLoadListUserEvent` (load from DB), `MyAppGetUserEvent(id)`, `MyAppDeleteUserEvent(user)` (delete + reload list). All handlers are `void`+`async`. State: `lib/src/my_app_state.dart` — one monolithic Equatable state with four `FormzSubmissionStatus` fields (`statusInsertUser/LoadListUser/DeleteUser/LoadUser`), `users`, nullable `user` (sentinel `_unsetUser` in `copyWith`).
- **Routing/Screens**: `lib/src/core/routes/app_route.dart` — if/else static router: `/` → `Splash`, `Home.routeName`, `Detail.routeName` (requires `DetailArgs`, falls back to error Scaffold), unknown → "Page Not Found". Screens: `splash.dart` (fires init in `initState`; BlocListener navigates to Home on success **or** failure, after a 1s Timer), `home.dart` (BlocListener delete snackbar + BlocBuilder list; failure state has a Retry button), `detail.dart` (`DetailArgs`, stale-user guard keeps the spinner until the screen's own load completes).
- **Platform transport config**: Android `android/app/src/main/res/xml/network_security_config.xml` sets `cleartextTrafficPermitted="true"`; iOS `ios/Runner/Info.plist` sets `NSAppTransportSecurity → NSAllowsArbitraryLoads = true`. Both deliberately permit the cleartext `http://` base URL.

**Note on source reports:** an earlier scout pass reported pull-to-refresh on Home; first-hand inspection (and grep) confirms **there is no `RefreshIndicator` anywhere in `lib/`** — the list loads on screen entry and via the failure-state Retry button only.

## 2. Strengths

- Clean repository seam: all infra errors translated to `RepositoryException` via `Error.throwWithStackTrace` (`app_repository.dart:31`); bloc never sees Dio or Isar directly.
- Atomic seed write in one transaction (`saveData`); lazy, retry-capable DB open; no DB operation can run before the DB is open.
- Careful state mechanics: nullable-aware `copyWith` sentinel; Detail's stale-user guard (`detail.dart:63-70`); correct `buildWhen`/`listenWhen` usage on all three screens.
- Failure paths navigate: Splash proceeds to Home on **both** success and failure — the app already survives offline cold starts once seeded.
- Server-id-as-Isar-key avoids the community fork's autoincrement persistence bug (#115); no `IsarLinks` avoids the silent link-removal bug (#122).

## 3. Offline-first assessment

| Scenario | Current behavior |
|---|---|
| Cold start, online | Splash → API fetch → **full DB replace** → "Init Data Done" → 1s → Home |
| Cold start, offline (seeded before) | Splash → API fails → "Offline Mode" → still → Home; DB serves the cached list ✅ |
| Cold start, offline, **never seeded** | Home shows "No users" — the empty state has **no retry/sync action** ❌ |
| Delete offline | Survives until the next *successful online* cold start, then **re-seeded** (clear-and-replace) ⚠️ |
| App open, long session | No refresh trigger at all — no pull-to-refresh, no connectivity listener; data stales until restart ❌ |
| Network black-hole | Splash bounded by the 30s Dio connect timeout, then navigates — acceptable but slow ❌ |

**Verdict:** "local-persisted, network-seeded" — roughly 70% offline-first already. The gaps are behavioral, not architectural, and are fixable within the agreed constraints.

## 4. Risk register

### Recommended (small, constraint-respecting)

1. **Splash gates navigation on network outcome** (`splash.dart:43-54`) — worst case ~31s wait on a hanging network. Offline-first would navigate on a fixed short timer and seed in the background.
2. **No refresh affordance** — add `RefreshIndicator` on Home → reuse `MyAppInitUserEvent` (no new event required).
3. **Empty-DB dead end** — the "No users" state should offer "Sync now" (reuse `MyAppInitUserEvent`).
4. **`http://` + broad transport exemptions** (`constants.dart`, both platform configs) — jsonplaceholder supports HTTPS; switching the one constant eventually allows dropping the exemptions.

### Accepted trade-offs (per interview answers — documented, not actioned)

- "Offline Mode" label shows for *any* failure, including malformed payloads — cosmetic mislabel (status-only errors agreed).
- Deleted users reappear after a successful refresh — inherent to clear-and-replace; acceptable under "just handling locally."
- Monolithic state coupling: `users` is written by load/delete paths; seed and load can interleave because handlers are `void async` (bloc cannot await them) — fine at this scale with a single bloc.
- Per-repository Isar instance — dormant risk while there is exactly one collection.
- Zero tests — replaced by a manual verification checklist (below).
- `Geo` lat/lng stored as `String` via `toString()` — display-only, acceptable.

### Ecosystem guardrails (verified 2026-09-25)

- `isar_community` 3.3.2 is the actively maintained fork (repo last push 2026-09-08; upstream `isar` dormant since 2023-04-25). Mobile-only use is squarely within its supported platforms (iOS/Android/Desktop; web explicitly not offered).
- Already aligned: server-id keys (fork bug #115), no `IsarLinks` (#122), embedded objects as the supported pattern.
- **One release-time action:** verify an iOS **release** build on a real device early (fork issue #68 — release-only library-load failure).
- Pins are current: `isar_community` 3.3.2, `dio` 5.11.1, `flutter_bloc` 9.1.1 — touch nothing.

### Manual verification checklist (in lieu of tests)

For any offline-first change: (1) first-ever launch offline; (2) seeded offline cold start; (3) delete → offline restart → online restart (expect re-seed per clear-and-replace); (4) airplane-mode toggle mid-session; (5) iOS **release** build on device.

## 5. Minimal offline-first evolution path (future option)

All UI/bloc-level — no schema change, single bloc, no new state fields:

1. Fixed-timer splash + background seed; Home listens for `statusInsertUser` success → re-dispatch `MyAppLoadListUserEvent`.
2. `RefreshIndicator` on Home → `MyAppInitUserEvent`.
3. "Sync now" action on the empty state.
4. Optional `connectivity_plus` reconnect → seed.
5. `https://` base URL constant (+ later removal of the two platform exemptions).

Touchpoints: `lib/src/ui/screens/splash.dart`, `lib/src/ui/screens/home.dart`, `lib/src/core/data/constants.dart` (+2 platform config files for item 5).
