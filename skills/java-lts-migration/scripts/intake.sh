#!/usr/bin/env bash
# intake.sh — summarize a Java project's build, Java version pins, JVM flags and
# frameworks, as input for MIGRATION_PLAN.md. Read-only; run from the project root.
#
# Usage: bash intake.sh [project-dir]
set -euo pipefail

ROOT="${1:-.}"
cd "$ROOT"

# Directories never worth scanning.
EXCLUDES=(--exclude-dir=.git --exclude-dir=target --exclude-dir=build \
  --exclude-dir=node_modules --exclude-dir=.gradle --exclude-dir=.idea --exclude-dir=out)

section() { printf '\n## %s\n' "$1"; }

# grep wrapper: prints matches as file:line:text, or "(none)".
find_in() {
  local pattern="$1"; shift
  local out
  out=$(grep -rEn "${EXCLUDES[@]}" "$@" -e "$pattern" . 2>/dev/null | head -40 || true)
  if [[ -n "$out" ]]; then printf '%s\n' "$out"; else echo "(none)"; fi
}

section "Build tool"
[[ -f pom.xml ]] && echo "maven: pom.xml ($(find . -name pom.xml -not -path '*/target/*' | wc -l | tr -d ' ') pom files)"
ls build.gradle build.gradle.kts settings.gradle settings.gradle.kts 2>/dev/null | sed 's/^/gradle: /' || true
[[ -f build.xml ]] && echo "ant: build.xml"
if [[ -f .mvn/wrapper/maven-wrapper.properties ]]; then
  echo "maven wrapper: $(grep -Eo 'apache-maven-[0-9.]+' .mvn/wrapper/maven-wrapper.properties | head -1)"
fi
if [[ -f gradle/wrapper/gradle-wrapper.properties ]]; then
  echo "gradle wrapper: $(grep -Eo 'gradle-[0-9.]+(-rc-[0-9]+)?' gradle/wrapper/gradle-wrapper.properties | head -1)"
fi

section "Java version in build files"
find_in '(maven\.compiler\.(release|source|target)|<release>|<source>1?\.?[0-9]+</source>|<target>1?\.?[0-9]+</target>|<java\.version>|sourceCompatibility|targetCompatibility|languageVersion|jvmTarget|release *=)' \
  --include=pom.xml --include='*.gradle' --include='*.gradle.kts' --include=build.xml --include=gradle.properties

section "JDK pins (tooling, CI, containers)"
for f in .java-version .sdkmanrc .tool-versions .jdk-version; do
  [[ -f "$f" ]] && echo "$f: $(tr '\n' ' ' < "$f")"
done
find_in '(java-version|setup-java|jdk:|JAVA_VERSION|openjdk|temurin|corretto|zulu|eclipse-temurin|FROM .*(jdk|jre|java))' \
  --include='*.yml' --include='*.yaml' --include='Dockerfile*' --include='*.dockerfile' --include=Jenkinsfile --include='*.groovy'

section "JVM flags (scripts, configs, charts)"
find_in '(-XX:|-Xlog|-Xloggc|--add-opens|--add-exports|--add-modules|--illegal-access|--enable-native-access|-Djava\.security\.manager|-Djava\.locale\.providers|-Djava\.(endorsed|ext)\.dirs|-Xbootclasspath|<argLine>|jvmArgs|MAVEN_OPTS|JAVA_OPTS|JAVA_TOOL_OPTIONS)' \
  --include='*.sh' --include='*.yml' --include='*.yaml' --include='Dockerfile*' --include=pom.xml \
  --include='*.gradle' --include='*.gradle.kts' --include=gradle.properties --include=jvm.config \
  --include='*.conf' --include='*.properties' --include='*.cmd' --include='*.bat'

section "Frameworks and test stack (declared dependencies)"
find_in '(spring-boot|spring-framework|springframework|lombok|mockito|powermock|jacoco|byte-buddy|bytebuddy|org\.ow2\.asm|mapstruct|hibernate|junit|groovy|kotlin|spotbugs|errorprone|javafx|openjfx|nashorn|jaxb|jaxws|jakarta\.)' \
  --include=pom.xml --include='*.gradle' --include='*.gradle.kts' --include='libs.versions.toml'

section "Removed or risky API usage in sources"
find_in 'import (javax\.(xml\.bind|xml\.ws|jws|annotation\.(PostConstruct|PreDestroy|Generated|Resource)|activation|transaction)|org\.omg|javafx|jdk\.nashorn|sun\.misc|sun\.reflect)\.' \
  --include='*.java' --include='*.kt' --include='*.groovy'
find_in '(setSecurityManager|URLClassLoader\)|Thread\.currentThread\(\)\.stop|\.stop\(\)|System\.getProperty\("java\.version"\)|new Locale\(|new URL\()' \
  --include='*.java'

section "Module system"
find . -name module-info.java -not -path '*/target/*' -not -path '*/build/*' 2>/dev/null | head -10 || true
echo "(module-info.java files listed above; none means classpath project)"

section "Installed JDK here"
java -version 2>&1 | grep -v JAVA_TOOL_OPTIONS | head -2 || echo "(no java on PATH)"
