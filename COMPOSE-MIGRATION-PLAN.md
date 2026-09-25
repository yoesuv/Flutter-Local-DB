# Implementation Plan — Refactor to Native Android (Kotlin + Jetpack Compose)

*Date: 2026-09-25 · Scope: 1:1 behavioral port of `flutter_local_db` v1.1.5+1 to a native Android app*

**Principle:** parity first. Port the *current* Flutter behavior exactly (single bloc, status-only errors, clear-and-replace seed, no new dependencies beyond the Android equivalents). The offline-first items in `REQUIREMENTS.md` (R1–R5) stay **out of scope** until parity is verified — they port cleanly afterwards.

---

## 1. Target stack

| Concern | Flutter today | Android target |
|---|---|---|
| UI | Flutter Material 3 | Jetpack Compose + Material 3 (teal seed, portrait-locked) |
| State | `flutter_bloc` (single `MyAppBloc`) | `MyAppViewModel` (single `ViewModel`, `StateFlow<MyAppState>`) |
| Local DB | `isar_community` 3.3.2 | Room 2.7.x (embedded objects via `@Embedded`, server id as PK) |
| Network | Dio 5.11.1 (30 s timeouts, response logging) | OkHttp 5.x + Retrofit 3.x, `HttpLoggingInterceptor` (debug-only) |
| JSON | hand-written `fromJson` | kotlinx-serialization 1.9.x |
| Async | Dart futures, `void async` handlers | Kotlin coroutines + Flow |
| DI | hard-instantiated repos | simple `ServiceLocator` object (no Hilt — matches "no DI container" today) |
| Errors | `RepositoryException` wrapping all infra errors | `RepositoryException` (same contract: UI only ever sees it) |

**App identity:** keep `applicationId = com.yoesuv.flutter_local_db`, `versionName = "1.1.5"`, `versionCode = 1`. Installing the native build replaces the Flutter app (same shared-UserId-free sandbox — note: the Room DB does **not** inherit Isar data; first launch re-seeds from the network).

**Gradle:** Gradle 9.x wrapper (reuse the 9.3.1 distribution already pinned in `android/gradle/wrapper/`), AGP 8.13+, Kotlin 2.2.x with the `org.jetbrains.kotlin.plugin.compose` plugin, `buildConfig = true`. minSdk 26, targetSdk/compileSdk = current stable (36). `usesCleartextTraffic` via the same `network_security_config.xml` pattern until REQUIREMENTS R5.

**Location:** new `android-native/` directory at the repo root (settings.gradle.kts, gradle wrapper, `app/` module). The Flutter `android/` host stays untouched until decommissioning.

## 2. File-by-file mapping

| Flutter source | Kotlin target |
|---|---|
| `lib/main.dart` | `MainActivity` + `MyAppApplication`; portrait via `android:screenOrientation="portrait"` in manifest (no runtime try/catch needed) |
| `lib/src/my_app.dart` | `MaterialTheme(colorScheme = lightColorScheme(seed = Teal))` in `ui/theme/Theme.kt`; `NavHost` replaces `onGenerateRoute` |
| `lib/src/core/data/constants.dart` | `Constants.kt` (`BASE_URL`, `TIMEOUT_SECONDS = 30L`) |
| `lib/src/core/errors/repository_exception.dart` | `RepositoryException(message, cause)` — identical contract |
| `lib/src/core/networks/network_helper.dart` | `NetworkHelper` (OkHttp client: timeouts, logging interceptor) + Retrofit `UserApi` (`@GET("users")`) |
| `lib/src/core/networks/logging_interceptor.dart` | `HttpLoggingInterceptor(BODY)` wired only when `BuildConfig.DEBUG` |
| `lib/src/core/repositories/app_repository.dart` | `AppRepository.getUser(): List<UserEntity>` — validates payload is a list, maps DTOs, wraps *every* infra error (HttpException/SerializationException/IOException) in `RepositoryException` |
| `lib/src/core/repositories/db_repository.dart` | Room's lazy singleton DB in `ServiceLocator` (replaces the self-healing open-future pattern) |
| `lib/src/core/repositories/db_user_repository.dart` | `DbUserRepository`: `saveData` = `@Transaction` `clearUsers()` + `insertAll` (atomic full replace, mirrors `writeTxn`), `getUsers`, `getUser(id)`, `delete(id)` (require non-null id at type level — see D2) |
| `lib/src/core/models/*.dart` | Room `@Entity UserEntity` (`@PrimaryKey val id: Long`, `@Embedded Address`, `@Embedded Company`, `@Embedded Geo`) + `@Serializable` DTOs with explicit mappers (DTO ≠ entity, like the hand-written fromJson today) |
| `lib/src/my_app_event.dart` | ViewModel functions `initUser()`, `loadList()`, `getUser(id)`, `deleteUser(user)` — events collapse into calls |
| `lib/src/my_app_state.dart` | `MyAppState` data class: four `UiStatus` enums (Initial/InProgress/Success/Failure = Formz values), `users: List<UserEntity>`, `selectedUser: UserEntity?` (nullable; copyWith uses an explicit `UserCleared` sentinel like `_unsetUser`) |
| `lib/src/my_app_bloc.dart` | `MyAppViewModel` — same handler bodies, coroutines on `viewModelScope` |
| `lib/src/core/routes/app_route.dart` | Navigation Compose: `/` → Splash, `home`, `detail/{id}`; unknown → generic "Page Not Found" screen; `DetailArgs(id)` becomes a typed route arg (no "missing arguments" branch needed) |
| `lib/src/ui/screens/splash.dart` | `SplashScreen`: on entry `viewModel.initUser()`; status text (Initial/Success "Init Data Done"/Failure "Offline Mode") via `collectAsStateWithLifecycle`; on terminal status, `LaunchedEffect` delay(1 s) → `navController.navigate("home") { popUpTo("/") { inclusive = true } }` |
| `lib/src/ui/screens/home.dart` | `HomeScreen`: entry `loadList()`; delete snackbar ("Delete Success" green / "Delete Failed" red, 1 s) via `SnackbarHostState` + one-shot status event; list/empty/failure states mirror current branches incl. Retry button |
| `lib/src/ui/widgets/item_user.dart` | `UserListItem` + `SwipeToDismissBox` (endToStart, red delete background) → `deleteUser(user)`; tap → `detail/{id}` |
| `lib/src/ui/screens/detail.dart` | `DetailScreen`: entry `getUser(id)`; failure → Retry; stale-guard ("user.id != args.id → keep spinner") is *free* here: `selectedUser` resets to null on `getUser` start, so show spinner until Success |
| `lib/src/ui/widgets/text_splash.dart` | inline `Text` composable |

**State-detail decisions (mirror the careful bits found in ANALYSIS.md):**
- D1: `users` is written by load *and* delete paths — keep both writing `state.users` exactly like today.
- D2: Flutter `User.id` is nullable; Room PK cannot be. Make entity `id: Long` and have `AppRepository` skip/map entries without a server id (jsonplaceholder always sends one). Deletion of an id-0 entry can't happen — acceptable.
- D3: keep the "any failure → Offline Mode" label (cosmetic mislabel accepted in ANALYSIS.md).

## 3. Phases

**P1 — Scaffold (goal: `./gradlew assembleDebug` green)**
`android-native/` with wrapper, `gradle.properties` (AndroidX, parallel), root/app `build.gradle.kts`, empty `MainActivity` + theme, manifest with INTERNET + portrait + launcher. Teal Material3 theme.

**P2 — Data layer**
DTOs + mappers, `UserApi`, `NetworkHelper`, Room (entities, `UserDao`, DB), `AppRepository`, `DbUserRepository`, `RepositoryException`, `ServiceLocator` (injectable interfaces like `AppRepository({NetworkHelper?})` today → constructor params).

**P3 — ViewModel**
`MyAppState` + `UiStatus`, `MyAppViewModel` with the four operations. Plain coroutines, no test code — per the standing constraint **no tests and no unit tests are created** (no test target, no test dependencies); verification is the P5 manual checklist only.

**P4 — UI**
Navigation graph, `SplashScreen` (timer + status text), `HomeScreen` (list, empty "No users", failure Retry, swipe-delete, snackbar), `DetailScreen` (all fields incl. address/company sections, stale-guard).

**P5 — Parity verification (manual, per no-tests constraint)**
1. Cold start online → splash shows "Init Data Done", ~1 s later Home shows list.
2. Cold start offline (seeded) → "Offline Mode" → Home shows cached list.
3. Cold start offline, never seeded → Home "No users".
4. Swipe-delete row → snackbar; offline restart → entry gone; online restart → re-seeded (clear-and-replace trade-off, expected).
5. Detail loads from DB; Retry on failure; spinner until own load completes.
6. Rotation locked to portrait; airplane-mode toggle mid-session → no crash, no auto-refresh (R4 intentionally not ported yet).
7. Release build (`assembleRelease`) on a real device.

**P6 — Decommission decision**
Keep both stacks until P5 passes, then either delete Flutter code or keep `android-native/` as the sole Android artifact and Flutter for iOS.

## 4. Dependencies (app module)

```kotlin
implementation(platform("androidx.compose:compose-bom:<current>"))
implementation("androidx.compose.material3:material3")
implementation("androidx.navigation:navigation-compose:<current>")
implementation("androidx.lifecycle:lifecycle-viewmodel-compose:<current>")
implementation("androidx.lifecycle:lifecycle-runtime-compose:<current>")
implementation("androidx.activity:activity-compose:<current>")
implementation("androidx.room:room-runtime:<current>")
implementation("androidx.room:room-ktx:<current>")
ksp("androidx.room:room-compiler:<current>")
implementation("com.squareup.retrofit2:retrofit:<current>")
implementation("com.squareup.okhttp3:okhttp:<current>")
implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:<current>")
implementation("com.jakewharton.retrofit:retrofit2-kotlinx-serialization-converter:<current>")
debugImplementation("com.squareup.okhttp3:logging-interceptor:<current>")
```

(Room compiler via KSP; version catalogue in `gradle/libs.versions.toml`.)

## 5. Risks / notes

- **Room replaces Isar:** same data model fits Room embedded objects 1:1; server-id-as-PK avoids all autoincrement concerns. `Geo.lat/lng` stay `String?` (`toString()` parity).
- **Atomic replace:** `saveData` must run clear + insertAll inside one `@Transaction` DAO method — do not split into two DAO calls.
- **One-shot UI events** (delete snackbar, splash navigation) should not be encoded in `MyAppState` to avoid re-firing on recomposition; expose a `SharedFlow<SideEffect>` from the ViewModel for those two cases only.
- **Cleartext HTTP:** keep `network_security_config.xml` allowing cleartext for now; the REQUIREMENTS R5 https switch ports over as a one-line change.
- **No tests, no unit tests:** per the standing constraint, no test source sets, no JUnit/kotlin.test dependencies, no CI test steps — P5 checklist replaces them; CI gate is `assembleDebug`/`assembleRelease` compiling.
