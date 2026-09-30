# OpenRewrite pass

OpenRewrite does the mechanical part of each hop (build config, removed APIs, plugin versions) deterministically. Run it without changing the project's build files.

## Recipe per hop

| Hop | Recipe |
|---|---|
| 8 → 11 | `org.openrewrite.java.migrate.Java8toJava11` |
| 11 → 17 | `org.openrewrite.java.migrate.UpgradeToJava17` |
| 17 → 21 | `org.openrewrite.java.migrate.UpgradeToJava21` |
| 21 → 25 | `org.openrewrite.java.migrate.UpgradeToJava25` |

The `UpgradeToJava*` recipes are cumulative (25 includes 21, 17 and 11). Use the recipe for the hop you are on, not the final target, so each hop's diff stays reviewable.

## Run it on the current (pre-hop) JDK

Parse the code with the JDK you are leaving. On a newer JDK, recipes that detect removed modules can silently do nothing: `AddJaxbAPIDependencies` no-ops when the project is parsed on JDK 11+ because `javax.xml.bind` is then not recognized as used (rewrite-migrate-java issue #1246; likely also affects `javax.annotation`, `javax.activation`, `javax.xml.soap` and JAX-WS). After the run, confirm with a compile that the expected dependencies were added.

## Maven (no pom change)

Check the current plugin version first (6.49.0 at time of writing, September 2026).

```bash
V=6.49.0
# 1. Dry run: writes target/rewrite/rewrite.patch
mvn -U org.openrewrite.maven:rewrite-maven-plugin:$V:dryRun \
  -Drewrite.recipeArtifactCoordinates=org.openrewrite.recipe:rewrite-migrate-java:RELEASE \
  -Drewrite.activeRecipes=org.openrewrite.java.migrate.UpgradeToJava17 \
  -Drewrite.exportDatatables=true
# 2. Review target/rewrite/rewrite.patch, then apply:
mvn -U org.openrewrite.maven:rewrite-maven-plugin:$V:run  <same -D flags>
```

## Gradle (no build change)

Create `init.gradle` **outside the repo** (for example in `/tmp`):

```groovy
initscript {
  repositories { maven { url "https://plugins.gradle.org/m2" } }
  dependencies { classpath("org.openrewrite:plugin:latest.release") }
}
rootProject {
  plugins.apply(org.openrewrite.gradle.RewritePlugin)
  dependencies { rewrite("org.openrewrite.recipe:rewrite-migrate-java:latest.release") }
  afterEvaluate {
    if (repositories.isEmpty()) { repositories { mavenCentral() } }
  }
}
```

```bash
./gradlew rewriteDryRun --init-script /tmp/init.gradle -Drewrite.activeRecipe=org.openrewrite.java.migrate.UpgradeToJava17
./gradlew rewriteRun    --init-script /tmp/init.gradle -Drewrite.activeRecipe=org.openrewrite.java.migrate.UpgradeToJava17
```

Do not combine the init script with a build that already has a `rewrite {}` block; use the project's own configuration in that case.

## Keep the diff mechanical

The upgrade recipes also apply "best practice" rewrites and plugin upgrades. Review the patch against the skill's principles. To exclude sub-recipes, write a declarative recipe **outside the repo** and point to it with `-Drewrite.configLocation=/tmp/rewrite.yml`:

```yaml
type: specs.openrewrite.org/v1beta/recipe
name: local.MinimalUpgradeToJava17
recipeList:
  - org.openrewrite.java.migrate.UpgradeBuildToJava17
  - org.openrewrite.java.migrate.UpgradePluginsForJava17
  # add only the sub-recipes you reviewed and want
```

Commit the recipe output on its own, naming the recipe and version, so reviewers can tell tool output from manual edits.

## Availability and fallback

Recipes are moving from Maven Central to the Code Genome Project repository (`https://artifacts.codegenomeproject.org/maven`), which requires an authenticated download token; older releases stay on Maven Central, and some recipe sets (for example Spring Boot 3.5+) need a Moderne subscription for prebuilt artifacts.

- If a token is configured in the user's `~/.m2/settings.xml` or Gradle properties, use it. Never write a token into the repo.
- Otherwise pin the newest plugin and recipe versions still on Maven Central.
- If neither works, skip this step, record it in `MIGRATION_PLAN.md`, and do the hop by hand with the hop reference.

## Out of scope here

`org.openrewrite.java.migrate.jakarta.JavaxMigrationToJakarta` and `org.openrewrite.java.spring.boot3.UpgradeSpringBoot_3_x` are framework migrations. Mention them as follow-ups when the framework gate in step 1 triggers; do not run them as part of a JDK hop.
