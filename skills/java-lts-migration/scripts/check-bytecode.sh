#!/usr/bin/env bash
# check-bytecode.sh — confirm compiled classes target the expected Java release.
# Reads the class-file major version (bytes 7-8) of every .class file in the
# build output. major = release + 44 (52=8, 55=11, 61=17, 65=21, 69=25).
#
# Usage: bash check-bytecode.sh <release> [project-dir]
# Exit code: 0 if every class matches, 1 on any mismatch, 2 if no classes found.
set -euo pipefail

RELEASE="${1:?usage: check-bytecode.sh <release> [project-dir]}"
ROOT="${2:-.}"
EXPECTED=$((RELEASE + 44))

mapfile -t CLASSES < <(find "$ROOT" -name '*.class' \
  \( -path '*/target/classes/*' -o -path '*/build/classes/*' \) 2>/dev/null)

if [[ ${#CLASSES[@]} -eq 0 ]]; then
  echo "no compiled classes under target/classes or build/classes (build first)" >&2
  exit 2
fi

# Count classes per major version; list up to 10 offenders.
declare -A COUNT=()
BAD=()
for f in "${CLASSES[@]}"; do
  major=$(od -An -tu1 -j6 -N2 "$f" | awk '{print $1 * 256 + $2}')
  COUNT[$major]=$(( ${COUNT[$major]:-0} + 1 ))
  if [[ "$major" -ne "$EXPECTED" && ${#BAD[@]} -lt 10 ]]; then BAD+=("$f (major $major)"); fi
done

for major in "${!COUNT[@]}"; do
  printf 'major %s (Java %s): %s classes\n' "$major" "$((major - 44))" "${COUNT[$major]}"
done | sort

if [[ ${#COUNT[@]} -eq 1 && -n "${COUNT[$EXPECTED]:-}" ]]; then
  echo "OK: all ${#CLASSES[@]} classes target Java $RELEASE"
  exit 0
fi

echo "MISMATCH: expected major $EXPECTED (Java $RELEASE). Examples:"
printf '  %s\n' "${BAD[@]}"
exit 1
