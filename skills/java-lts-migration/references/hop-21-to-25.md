# Hop: Java 21 → 25

Class file major version 69. Tooling to run on 25: Gradle 9.1.0+ (both for toolchains and to run Gradle itself on 25), current Maven compiler and surefire plugins. OpenRewrite recipe: `UpgradeToJava25` (run on JDK 21). Kotlin modules need Kotlin 2.3.0+ to emit Java 25 bytecode; OpenRewrite caps Kotlin 1.x modules at 24.

Most breaking changes below arrived in JDK 22–24, so they show up on this hop even though 25 itself changed little.

## Framework gate

Spring Framework 5.3 / Boot 2.7 stop at JDK 21. On this hop the project needs Spring Boot 3.5.5+ or 4.0 (Framework 6.2 or 7.x). If it is still on Boot 2.x, stop: the Boot 3 migration (and `jakarta.*`) comes first, as a separate piece of work.

## Library minimums

See `library-matrix.md`. Highlights: Lombok 1.18.42+, JaCoCo 0.8.14, Byte Buddy 1.17.5+, ASM 9.8, Mockito 5.19+, Groovy 5.0, SpotBugs 4.9.7+. Old versions fail with `Unsupported class file major version 69`.

## Behavior changes

- **Annotation processing is no longer implicit** (JDK 23). Processors found on the classpath, such as Lombok, MapStruct or the Hibernate metamodel generator, silently stop running and generated code goes missing. Declare them explicitly: `annotationProcessorPaths` in the Maven compiler plugin, or the `annotationProcessor` configuration in Gradle. `-proc:full` (Maven: `-Dmaven.compiler.proc=full`) restores the old behavior but is the fallback, not the fix.
- **Security Manager permanently disabled** (JEP 486, JDK 24). `-Djava.security.manager` makes the JVM fail at startup and `System.setSecurityManager` always throws. Remove the usage; there is no shim.
- **`sun.misc.Unsafe` memory-access methods warn at runtime** by default (JEP 498, JDK 24). Upgrade the library using them (Netty, older Guava/Caffeine, serialization libraries). `--sun-misc-unsafe-memory-access=allow` silences it temporarily; deny-by-default is planned for a later release.
- **Native access warnings** (JEP 472, JDK 24): loading native code via JNI or `System.loadLibrary` from the classpath warns. Add `--enable-native-access=ALL-UNNAMED` (or the module name) for libraries that need it: Netty native transports, JNA, SQLite and RocksDB drivers.
- **COMPAT locale provider removed** (JDK 23). `-Djava.locale.providers=COMPAT` has no effect any more; replace any earlier shim with explicit formats.
- **TLS_RSA cipher suites disabled** (JDK 24; also in 21.0.10+).
- **Non-generational ZGC removed** (JEP 490, JDK 24). ZGC is always generational.
- **32-bit x86 port removed** (JEP 503, JDK 25): check 32-bit base images and CI agents.
- **Preview APIs changed:** string templates (preview in 21/22) were withdrawn. Code built with `--enable-preview` on 21 must be recompiled and fixed.
- `Thread.suspend/resume` and `ThreadGroup.stop` throw `UnsupportedOperationException`.
- Compiling with `--release 8` prints a deprecation warning; matters for libraries built with `-Werror`.

## Flags to remove

- `-XX:+ZGenerational`, `-XX:-ZGenerational` (obsolete)
- `-Djava.security.manager` in any form
- `-Djava.locale.providers=COMPAT` (no effect)
- `-XX:+EnableDynamicAgentLoading` once agents are attached with `-javaagent`
