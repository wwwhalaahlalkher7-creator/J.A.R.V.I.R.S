#!/usr/bin/env bash
set -uo pipefail
LOG_FILE="${RUNNER_TEMP:-/tmp}/jarvis-flutter-analyze.log"
flutter analyze --no-fatal-infos >"$LOG_FILE" 2>&1
status=$?
cat "$LOG_FILE" | grep -E '^  (error|warning|info) •|^error •|^warning •|^info •' | head -n 120 || true
echo ""
Full analyzer log: $LOG_FILE"
exit $status
