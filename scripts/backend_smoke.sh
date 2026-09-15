#!/usr/bin/env bash
set -euo pipefail

HOST="127.0.0.1"
PORT="19001"
LOG_FILE="$(mktemp)"
cleanup() {
  if [[ -n "${SERVER_PID:-}" ]]; then
    kill "$SERVER_PID" 2>/dev/null || true
    wait "$SERVER_PID" 2>/dev/null || true
  fi
  rm -f "$LOG_FILE"
}
trap cleanup EXIT

HERMES_MOBILE_HOST="$HOST" HERMES_MOBILE_PORT="$PORT" \
  python -m hermes_mobile_server --host "$HOST" --port "$PORT" >"$LOG_FILE" 2>&1 &
SERVER_PID=$!

for _ in $(seq 1 30); do
  if curl -fsS "http://$HOST:$PORT/api/v1/health" > /tmp/jarvis-health.json; then
    python - <<'PY'
import json
with open('/tmp/jarvis-health.json', encoding='utf-8') as f:
    data = json.load(f)
assert data.get('status') in {'ok', 'degraded'}, data
print('JARVIS backend health:', data)
PY
    exit 0
  fi
  sleep 1
done

cat "$LOG_FILE"
exit 1
