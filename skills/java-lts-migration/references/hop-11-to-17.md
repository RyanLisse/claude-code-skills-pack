# Hop: Java 11 → 17

Class file major version 61. Tooling to run on 17: Maven compiler plugin 3.8.1+, Gradle 7.3+. OpenRewrite recipe: `UpgradeToJava17` (run on JDK 11).

## Strong encapsulation (the main event)

Reflection into JDK internals now throws `InaccessibleObjectException`, and `--illegal-access` no longer exists (JEP 403).

1. Upgrade the offending library (the exception names the module and package).
2. If no fixed version exists, add a targeted flag: `--add-opens java.base/java.lang=ALL-UNNAMED` (adjust module/package). For surefire, put it in `argLine` and keep `@{argLine}` so JaCoCo's agent still loads. For fat JARs the `Add-Opens` manifest attribute also works.
3. Compiler plugins such as Error Prone and google-java-format need `--add-exports` for `jdk.compiler`; follow their docs.
4. Record every flag in the plan with the library issue that will remove it.

## Removed

- **Nashorn:** add `org.openjdk.nashorn:nashorn-core` (package becomes `org.openjdk.nashorn`, requires Java 11+) or move to GraalJS
- **CMS** garbage collector: switch to G1 (default) or ZGC
- Pack200 tools and API, RMI Activation, experimental AOT and Graal JIT, `Unsafe.defineAnonymousClass`
- Security Manager and the Applet API are deprecated for removal and log warnings

## Library minimums

See `library-matrix.md`. Highlights: ASM 9.1, Byte Buddy 1.11, Lombok 1.18.22, Mockito 4, JaCoCo 0.8.7, Groovy 3.0.9, Spring Framework 5.3 / Boot 2.5.5. PowerMock does not work reliably on 17; replace it with Mockito inline mocking or report it as a blocker. Spring Boot 3 (requires 17 and `jakarta.*`) is a separate migration.

## Behavior changes

- **Helpful NullPointerException messages** are on by default; tests that assert on NPE messages, or on a `null` message, fail.
- **TLS 1.0 and 1.1** are disabled by default. Fix the endpoint; editing `jdk.tls.disabledAlgorithms` is a documented last resort.
- **`java.lang.Record`:** a class named `Record` reached through a wildcard import now clashes; import it explicitly.
- Newer CLDR data shifts some locale formats again.
- `sun.misc.Unsafe` and `sun.reflect` stay accessible via `jdk.unsupported`; most other `sun.*` and `com.sun.*` internals do not.

## Flags to remove

- `-XX:+UseConcMarkSweepGC` and all `-XX:CMS*` flags
- `--illegal-access=...`
- `-XX:+AggressiveOpts`
- `-XX:+UseBiasedLocking` and related biased-locking flags (disabled and deprecated in 15)
