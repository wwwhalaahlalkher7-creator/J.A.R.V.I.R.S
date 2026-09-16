# JARVIS Cloud Mobile Server

This server can run without a local computer. The container is based on the
official `nousresearch/hermes-agent` image and adds the JARVIS Mobile Server.

## Required environment variables

- `HERMES_MOBILE_API_KEY`: a long random secret used by the Flutter app.
- One Hermes model provider credential, for example `OPENROUTER_API_KEY`.

The server listens on `PORT` supplied by the hosting platform and binds to
`0.0.0.0` for public HTTPS access.

## Render

Create a **Web Service** from the repository. The repository already contains
`render.yaml`; it uses `server/` as the root directory and the Dockerfile there.
After deployment, copy the generated HTTPS service URL into the JARVIS Mobile
Server setting, then use the exact same `HERMES_MOBILE_API_KEY` in the app.

Free Render web services can spin down after inactivity, so the first request
after idle time may take longer. This is acceptable for the first E2E milestone.

## Railway

Create a service from the GitHub repository and set its **Root Directory** to
`server/`. Railway automatically detects `server/Dockerfile`. Add the same
`HERMES_MOBILE_API_KEY` and provider key as service variables.

## Model configuration

Hermes still needs a configured model provider. The recommended first test is
to set a provider API key as a service secret, then configure the corresponding
model in Hermes. Do not commit API keys to Git.
