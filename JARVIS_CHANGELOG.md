# JARVIS V0.4 Cloud Foundation

- Added a blitz.cloud-compatible Docker runtime for the Mobile Server.
- Runtime uses port 8080, linux/amd64, and uid/gid 1000 compatibility.
- Added cloud deployment documentation for the first end-to-end test.
- Secrets remain environment variables and are not committed.

# JARVIS 0.3.0 — Executable Development Workflow

- Added Backend CI with compile, API/core tests, and server health smoke test.
- Added Flutter CI with pinned Flutter 3.47.1 analysis/tests.
- Added Android Debug Build workflow that publishes an APK artifact.
- Added `JARVIS_DEV_WORKFLOW.md` describing milestone-based development and testing.
- Added a local backend smoke-test script.
- Bumped JARVIS foundation version to 0.3.0+3.

# JARVIS Changelog

## 0.3.2 — Test Contract Alignment

- Fixed stale Flutter test references to the old `Hermes` product title; shell assertions now use `JarvisConfig.productName`.
- Updated the Agent screen scroll contract test to match the current `HermesPageScaffold` + `RefreshIndicator` + `ListView` implementation instead of the retired `NestedScrollView`/`SliverAppBar` structure.
- Kept Liquid golden tests enabled; no golden assertion was disabled or weakened.
- Added an explicit manual GitHub Actions `update_goldens` workflow input that regenerates the four Liquid preview baselines with Flutter 3.47.1 and commits only the changed preview goldens.

## 0.2.1 — UI/Identity Core

- Continued the independent JARVIS product layer on top of Hermes Mobile.
- Updated core user-facing English and Arabic copy from Hermes to JARVIS where it represents the assistant experience.
- Kept Hermes naming where it refers to the underlying agent/backend technology.
- Kept `HermesAdapter`, `JarvisRuntime`, `JarvisRuntimeStore`, and `MemoryService` as stable boundaries for future runtime and memory work.
- No vector database was added yet; ChromaDB remains an optional future adapter.
- No destructive removal of existing Hermes Mobile features.

## Validation

- Localization source files updated consistently in English and Arabic.
- Python server syntax was validated before packaging.
- Flutter analysis could not be executed in this environment because the Flutter SDK is not installed. Run `flutter analyze` and `flutter test` after importing the project into the development environment.
