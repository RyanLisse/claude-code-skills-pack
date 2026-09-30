#!/usr/bin/env bash
# test-count.sh — total the JUnit XML reports written by Maven Surefire/Failsafe
# and Gradle, so the baseline and target runs can be compared exactly.
#
# Usage: bash test-count.sh [project-dir]
# Output (one line): tests=N failures=F errors=E skipped=S reports=R
# Exit code: 0 if reports were found, 2 if none (run the build first).
set -euo pipefail

ROOT="${1:-.}"

# Collect report files from every module.
mapfile -t REPORTS < <(find "$ROOT" \
  \( -path '*/target/surefire-reports/TEST-*.xml' \
  -o -path '*/target/failsafe-reports/TEST-*.xml' \
  -o -path '*/build/test-results/*/TEST-*.xml' \) \
  -not -path '*/node_modules/*' 2>/dev/null)

if [[ ${#REPORTS[@]} -eq 0 ]]; then
  echo "no JUnit XML reports found under $ROOT (run the tests first)" >&2
  exit 2
fi

# Sum the attributes of each top-level <testsuite ...> element.
# Attribute order differs between tools, so parse each attribute by name.
awk '
  /<testsuite[ >]/ && !/<testsuites/ {
    line = $0
    for (i = 1; i <= 4; i++) {
      split("tests failures errors skipped", names, " ")
      name = names[i]
      if (match(line, name "=\"[0-9]+\"")) {
        v = substr(line, RSTART + length(name) + 2, RLENGTH - length(name) - 3)
        sum[name] += v
      }
    }
    reports++
  }
  END {
    printf "tests=%d failures=%d errors=%d skipped=%d reports=%d\n",
      sum["tests"], sum["failures"], sum["errors"], sum["skipped"], reports
  }
' "${REPORTS[@]}"
