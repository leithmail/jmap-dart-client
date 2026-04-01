#!/usr/bin/env bash
set -e

dart test --coverage=coverage
dart run coverage:format_coverage \
  --lcov \
  --in=coverage \
  --out=coverage/lcov.info \
  --report-on=lib \
  --ignore-files='**/*.g.dart,**/*.freezed.dart'

if command -v genhtml >/dev/null 2>&1; then
  genhtml coverage/lcov.info -o coverage/html
  echo "HTML coverage generated at coverage/html/index.html"
else
  echo "genhtml not found; skipping HTML report generation."
fi
