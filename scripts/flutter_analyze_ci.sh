#!/usr/bin/env bash
set -uo pipefail

LOG_FILE="${RUNNER_TEMP:-/tmp}/jarvis-flutter-analyze.log"
SUMMARY_FILE="${RUNNER_TEMP:-/tmp}/jarvis-flutter-analyze-summary.log"

flutter analyze --no-fatal-infos >"$LOG_FILE" 2>&1
status=$?

# Keep only actionable analyzer diagnostics for the CI log.
grep -E '(^|[[:space:]])(error|warning) •' "$LOG_FILE" >"$SUMMARY_FILE" || true

errors=$(grep -cE '(^|[[:space:]])error •' "$SUMMARY_FILE" || true)
warnings=$(grep -cE '(^|[[:space:]])warning •' "$SUMMARY_FILE" || true)

echo ""
echo "========================================"
echo "JARVIS Flutter Analyze"
echo "========================================"
echo "Errors: $errors"
echo "Warnings: $warnings"

if [ "$status" -eq 0 ]; then
  echo "كلشي بخير — Flutter Analyze نجح."
  echo "========================================"
  exit 0
fi

echo ""
echo "تفاصيل الأخطاء والتنبيهات:"
if [ -s "$SUMMARY_FILE" ]; then
  cat "$SUMMARY_FILE"
else
  echo "لم يتم استخراج أخطاء/تنبيهات من خرج analyzer. راجع سبب الفشل في الخطوات السابقة."
fi

echo "========================================"
exit "$status"
