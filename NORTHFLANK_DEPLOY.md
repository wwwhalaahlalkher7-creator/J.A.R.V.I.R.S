# JARVIS — Northflank deployment

Northflank can build a Combined Service directly from the GitHub repository using the root `Dockerfile`.

## Service

- Service type: **Combined**
- Repository: this JARVIS repository
- Branch: `main`
- Build option: **Dockerfile**
- Dockerfile path: `/Dockerfile`
- Build context: `/`
- Internal port: **8080**
- Protocol: **HTTP**
- Public: **enabled**

The application listens on `0.0.0.0` and uses `${PORT:-8080}`. Northflank can expose the configured HTTP port publicly and provides HTTPS automatically.

## Runtime secrets

Add these as Northflank runtime environment variables. Never commit their values to GitHub:

- `HERMES_MOBILE_API_KEY`
- The provider/model API key required by the Hermes configuration (for example `OPENROUTER_API_KEY` if that is the selected provider)

## Health check

Use the Mobile Server's health endpoint only after the first successful deployment. If the endpoint path differs in the current server implementation, use the endpoint exposed by the server logs/API documentation rather than inventing a path.

## First deployment

1. Connect GitHub.
2. Create a **Combined** service.
3. Select `main`.
4. Select **Dockerfile**.
5. Leave Dockerfile path as `/Dockerfile`.
6. Add public HTTP port `8080`.
7. Add the runtime secrets.
8. Create the service and inspect the build/runtime logs.
9. Copy the generated public HTTPS URL into JARVIS Mobile Server settings.

Do not put API keys in this repository or in the Dockerfile.
