# JARVIS

**Local-first personal AI assistant for Android and desktop.**

JARVIS is an independent Flutter project built around the open-source Hermes
Agent runtime. The goal is to provide a practical personal assistant without
requiring a paid VPS or a mandatory cloud database.

## Current status

**V0.1 — foundation**

The first milestone keeps the mature parts of the source client working while
introducing a clean JARVIS product layer. It includes:

- Flutter client for Android, Web, iOS and Windows runners present in this base.
- HTTP/WebSocket connection to the local Mobile Server.
- Hermes Agent as the current agent engine.
- `HermesAdapter` boundary for future runtime changes.
- `MemoryService` boundary with an ephemeral implementation for tests.
- Local-first architecture; no ChromaDB or VPS is required at this stage.

## Architecture

```text
JARVIS Flutter App
       |
       | HTTP + WebSocket
       v
JARVIS Mobile Server layer
       |
       v
Hermes Agent
       |
       +-- models/providers
       +-- skills/tools/MCP
       +-- local workspace
       +-- agent memory
```

## Local-first modes

1. **Local** — JARVIS and the server run on the same computer.
2. **LAN** — Android connects to the server running on a trusted computer.
3. **External model provider** — Hermes can use a provider when configured.
4. **Future remote mode** — optional; not required for normal operation.

## Development prerequisites

- Flutter/Dart matching the source base's validated toolchain.
- Python 3.11+.
- `uv` for the server environment.
- A working Hermes Agent installation.

## Start the server

```bash
cd server
uv sync
HERMES_DASHBOARD_PUBLIC_URL= uv run hermes-mobile-server --host 127.0.0.1 --port 9001
```

For LAN testing, bind to `0.0.0.0` only on a trusted network and keep the API
key protected.

## Start Flutter

```bash
flutter pub get
flutter gen-l10n
flutter run -d chrome
```

For Android:

```bash
flutter run -d android
```

## Project structure

- `lib/core/jarvis/` — JARVIS-specific boundaries and composition.
- `lib/` — Flutter application and retained Hermes-compatible client features.
- `server/` — local FastAPI mobile-server layer.
- `docs/architecture/` — architecture decisions and evolution notes.
- `THIRD_PARTY_NOTICES.md` — upstream attribution and license notes.

## Roadmap

- V0.2: JARVIS home/command experience and connection profiles.
- V0.3: durable local memory.
- V0.4: voice input/output.
- V0.5: permissioned Android/Windows tools.
- V0.6: skills and MCP management through JARVIS concepts.
- V0.7+: automation and optional remote deployment.

## Security

JARVIS is designed to be local-first. Never commit API keys, model-provider
secrets, signing keys, or private configuration. Do not expose the local server
to the public internet without appropriate authentication, TLS, and access
controls.

## License

See `LICENSE` and `THIRD_PARTY_NOTICES.md`.


## JARVIS Architecture

JARVIS is the product layer built on top of the open-source Hermes Mobile client.
The project is intentionally independent of the upstream Git repository while
retaining the required third-party notices and licenses.

- **Client:** Flutter (Android, Windows, Web, iOS where supported by the base project)
- **Agent engine:** Hermes Agent
- **Transport:** existing Hermes Mobile HTTP/WebSocket API
- **Runtime boundary:** `lib/core/jarvis/`
- **Memory boundary:** `MemoryService` (ephemeral in V0.2; durable/vector backends can be added later)
- **Connection bridge:** `JarvisRuntimeStore` keeps product code independent from connection lifecycle details.

### V0.2 Foundation

This release starts the productization layer without rewriting Hermes features.
The active connection is projected into a nullable JARVIS runtime, allowing the
application to start before a backend is configured and keeping future runtime
changes localized behind the JARVIS boundary.

## JARVIS development and CI

The project is now organized as an independent JARVIS application around the existing Hermes Mobile transport/runtime boundary. See `JARVIS_DEV_WORKFLOW.md` for the executable development loop and GitHub Actions.

CI provides three concrete checkpoints: backend tests + health smoke test, Flutter analysis/tests, and an Android debug APK artifact.
