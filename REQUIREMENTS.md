# Requirements — Offline-First Evolution (Minimal Path)

*Date: 2026-09-25 · Source: `ANALYSIS.md` §5 (minimal offline-first evolution path)*

**Constraints honored (from interview):** local-only handling · single `MyAppBloc` · status-only errors · no tests (manual verification only) · mobile-only · no schema changes · stay on `isar_community`.

---

## 1. Scope

Five behavioral changes, all UI/bloc-level. No schema change, no new state fields, no new events (existing `MyAppInitUserEvent` / `MyAppLoadListUserEvent` are reused).

**Non-goals:** server sync/merge semantics, upserts or tombstones, per-feature blocs, error-message surfacing to UI, web platform, DB migration, automated tests.

## 2. Requirements

### R1 — Decouple navigation from seeding (splash + background refresh)
The splash screen must not wait for the network result before navigating.
- **R1.1** Splash navigates to Home on a fixed timer, regardless of API outcome.
- **R1.2** The seed (`MyAppInitUserEvent`) continues to run in the background from Splash; on success, Home re-dispatches `MyAppLoadListUserEvent` so a fresh list appears without user action.
- **R1.3** Seed failure is silent at the splash level (status-only; no dialog/snackbar).
- **Acceptance:** cold start offline (previously seeded) → Home appears within the fixed timer and shows cached data; toggling online and restarting updates the list without extra taps.

### R2 — Pull-to-refresh on Home
- **R2.1** Home list is wrapped in `RefreshIndicator`; pull dispatches `MyAppInitUserEvent`.
- **R2.2** On seed success, the list re-loads (via R1.2's reload path).
- **Acceptance:** pull-to-refresh online updates list; offline, the gesture ends gracefully with no crash and no error text (status-only).

### R3 — "Sync now" on empty state
- **R3.1** When `users` is empty and the list load succeeded, the empty state shows a "Sync now" action dispatching `MyAppInitUserEvent`.
- **Acceptance:** first-ever launch offline → Home shows "No users" **with** a "Sync now" action (no dead end); after going online and tapping it, the list populates.

### R4 — Reconnect-triggered seed *(optional — see D4)*
- **R4.1** When connectivity is regained mid-session, dispatch `MyAppInitUserEvent` once.
- **Acceptance:** airplane-mode toggle mid-session → after reconnect, list reflects fresh server data without restart.

### R5 — HTTPS base URL
- **R5.1** `BASE_URL` in `lib/src/core/data/constants.dart` switches to `https://jsonplaceholder.typicode.com/`.
- **R5.2** Platform transport exemptions (Android `network_security_config.xml`, iOS `NSAppTransportSecurity`) — see D5.
- **Acceptance:** all existing scenarios (seed, refresh, detail) pass over HTTPS on both platforms.

## 3. Open decisions — **DECIDE** markers

| # | Decision | Options |
|---|---|---|
| **D1** | Splash fixed-timer length | (a) 1s · (b) 2s · (c) other |
| **D2** | Pull-to-refresh failure feedback (status-only constraint) | (a) none (spinner just ends) · (b) neutral SnackBar "Sync failed" |
| **D3** | "Sync now" failure feedback | (a) none · (b) neutral SnackBar "Sync failed" |
| **D4** | `connectivity_plus` in scope? | (a) yes — adds the only new dependency · (b) defer |
| **D5** | HTTPS switch breadth | (a) constant only, keep exemptions for now · (b) constant + remove both exemptions in this change |

## 4. Verification (manual — per no-tests decision)

Checklist (mirrors `ANALYSIS.md` §4):
1. First-ever launch, offline → "No users" + "Sync now"; sync works after going online.
2. Seeded offline cold start → cached list within the D1 timer.
3. Delete → offline restart → online restart → user re-seeds (expected under clear-and-replace; documented trade-off).
4. Airplane-mode toggle mid-session → R4 behavior (if D4 = yes).
5. iOS **release** build on a real device (fork issue #68 guardrail).
6. All flows over HTTPS (R5).

**Touchpoints:** `lib/src/ui/screens/splash.dart` · `lib/src/ui/screens/home.dart` · `lib/src/core/data/constants.dart` · (D4) `pubspec.yaml` · (D5-b) two platform config files.
