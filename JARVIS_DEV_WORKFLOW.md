# JARVIS development workflow

JARVIS is developed in milestones, not as a ZIP per tiny code change.

## What is executable now

The repository contains three GitHub Actions workflows:

- **Backend CI** — compiles the Python server, runs backend API/core tests, and starts the server for a health smoke test.
- **Flutter & Android CI** — installs the pinned Flutter toolchain, analyzes the application, and runs Flutter tests.
- **Android Debug Build** — produces an installable debug APK as a GitHub Actions artifact.

The Android build is intentionally debug-only at this stage. No signing keys or production credentials belong in CI yet.

## Local architecture

```text
Flutter JARVIS app
        │ HTTP / WebSocket
        ▼
JARVIS Mobile Server
        │
        ▼
Hermes Agent
        │
        ├── tools / skills / MCP
        ├── agent memory
        └── configured LLM provider
```

## Milestone rule

A new ZIP should only be produced after a meaningful milestone or when a user-facing test checkpoint is ready. Intermediate edits stay in the working tree.

The intended loop is:

1. Implement a milestone.
2. Run the available local/CI checks.
3. Produce one ZIP checkpoint.
4. User imports that checkpoint into their repository.
5. User runs the Android build and app test.
6. Findings feed the next milestone.

This avoids repeatedly replacing the repository for every small change.
