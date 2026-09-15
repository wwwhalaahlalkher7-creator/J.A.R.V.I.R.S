# JARVIS Foundation

## Goal

JARVIS is an independent Flutter client for a personal AI assistant. Hermes
Agent is the current agent engine, not the product identity.

## V0.1 boundaries

```text
Flutter JARVIS
    |
    +-- JARVIS product layer
    |     +-- JarvisRuntime
    |     +-- HermesAdapter
    |     +-- MemoryService
    |
    +-- Existing Hermes-compatible client/state layer
    |
    +-- HTTP/WebSocket
              |
        Mobile Server
              |
        Hermes Agent
```

### Why this shape?

- Keep the proven streaming/session implementation from the source project.
- Prevent Hermes-specific details from spreading into new JARVIS features.
- Start local-first and avoid a mandatory VPS or hosted vector database.
- Keep memory replaceable: Hermes memory now; structured local storage and an
  optional ChromaDB adapter later if tests demonstrate a need.
- Add Android/desktop automation only behind explicit permission boundaries.

## First implementation milestone

1. Independent JARVIS product identity and package metadata.
2. Stable `HermesAdapter` boundary.
3. `MemoryService` abstraction with a deterministic test implementation.
4. `JarvisRuntime` composition root.
5. Preserve upstream functionality while the new product layer grows.

## Planned milestones

- V0.2: JARVIS home/command surface and local/LAN connection profiles.
- V0.3: durable local memory and memory inspection UI.
- V0.4: voice pipeline.
- V0.5: permissioned Android/Windows tools.
- V0.6: skills/MCP capability management exposed through JARVIS concepts.
- V0.7+: automation, wake-word experiments, and optional remote deployment.

## Security principles

- Local-first by default.
- Never commit API keys or model-provider secrets.
- Never expose the mobile server publicly without authentication and TLS.
- Tool actions that can change files, run commands, or control devices must be
  explicit and permissioned.
