# JARVIS Mobile Server + Hermes Agent
# Northflank deployment image.
FROM nousresearch/hermes-agent:latest

USER root
WORKDIR /opt/jarvis/server
COPY server/ /opt/jarvis/server/

RUN uv venv /opt/jarvis/.venv \
    && uv pip install --python /opt/jarvis/.venv/bin/python --no-cache-dir . \
    && mkdir -p /opt/data /opt/jarvis/workspace \
    && chown -R 1000:1000 /opt/jarvis /opt/data

ENV PATH="/opt/hermes/bin:/opt/jarvis/.venv/bin:${PATH}" \
    HERMES_HOME="/opt/data" \
    HERMES_MOBILE_HOST="0.0.0.0" \
    HERMES_MOBILE_PORT="8080" \
    HERMES_MOBILE_SERVE_HOST="127.0.0.1" \
    HERMES_MOBILE_SERVE_PORT="0" \
    HERMES_MOBILE_WORKSPACE="/opt/jarvis/workspace" \
    HERMES_DASHBOARD_PUBLIC_URL="" \
    HERMES_MOBILE_PROXY_IDLE_TIMEOUT="120"

USER 1000:1000
EXPOSE 8080

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["exec /opt/jarvis/.venv/bin/hermes-mobile-server --host 0.0.0.0 --port ${PORT:-8080}"]
