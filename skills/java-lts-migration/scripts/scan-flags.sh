#!/usr/bin/env bash
# scan-flags.sh — find JVM flags that are removed, obsolete or ineffective on the
# target JDK, anywhere they can hide (scripts, Dockerfiles, CI, charts, build files).
#
# Usage: bash scan-flags.sh <target-release> [project-dir]
# Exit code: 0 if clean, 1 if any flag that no longer works on the target was found.
set -euo pipefail

TARGET="${1:?usage: scan-flags.sh <target-release> [project-dir]}"
ROOT="${2:-.}"

# Each rule: "<first JDK where it breaks or is ignored>|<regex>|<what to do>"
RULES=(
  "9|-XX:\+PrintGCDetails|-XX:\+PrintGCDateStamps|-Xloggc:|UseGCLogFileRotation|replace with -Xlog:gc*"
  "9|-Djava\.(endorsed|ext)\.dirs|remove; mechanism is gone"
  "9|-Xbootclasspath/p:|remove; only -Xbootclasspath/a: remains"
  "11|-XX:\+UseCGroupMemoryLimitForHeap|remove; use -XX:MaxRAMPercentage"
  "11|-XX:\+AggressiveOpts|remove"
  "14|-XX:\+UseConcMarkSweepGC|-XX:CMS[A-Za-z]+|remove CMS; use G1 or ZGC"
  "18|-XX:[+-]UseBiasedLocking|remove; biased locking is gone"
  "17|--illegal-access|remove; use targeted --add-opens"
  "9|-XX:(Max)?PermSize|remove; PermGen is gone"
  "23|-Djava\.locale\.providers=[^ \"]*COMPAT|use explicit formats; COMPAT is gone"
  "24|-XX:[+-]ZGenerational|remove; ZGC is always generational"
  "24|-Djava\.security\.manager|remove; Security Manager is permanently disabled"
)

GREP_OPTS=(-rEn --exclude-dir=.git --exclude-dir=target --exclude-dir=build \
  --exclude-dir=node_modules --exclude-dir=.gradle --exclude-dir=.idea \
  --include='*.sh' --include='*.cmd' --include='*.bat' --include='*.yml' --include='*.yaml' \
  --include='Dockerfile*' --include='*.dockerfile' --include=pom.xml --include='*.gradle' \
  --include='*.gradle.kts' --include=gradle.properties --include=jvm.config --include='*.conf' \
  --include='*.properties' --include=Jenkinsfile --include='*.env' --include='*.service')

found=0
for rule in "${RULES[@]}"; do
  since="${rule%%|*}"
  rest="${rule#*|}"
  advice="${rest##*|}"
  regex="${rest%|*}"
  (( TARGET >= since )) || continue
  hits=$(grep "${GREP_OPTS[@]}" -e "$regex" "$ROOT" 2>/dev/null || true)
  if [[ -n "$hits" ]]; then
    found=1
    printf '\n[breaks from JDK %s] %s\n%s\n' "$since" "$advice" "$hits"
  fi
done

if (( found == 0 )); then
  echo "OK: no removed or obsolete JVM flags for JDK $TARGET"
  exit 0
fi
exit 1
