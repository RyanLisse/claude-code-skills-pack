# Hop: Java 17 → 21

Class file major version 65. Tooling to run on 21: Maven compiler plugin 3.11+, Gradle 8.5+. OpenRewrite recipe: `UpgradeToJava21` (run on JDK 17).

## Library minimums

See `library-matrix.md`. Highlights: ASM 9.5, Lombok 1.18.30, Mockito 5, JaCoCo 0.8.11, Spring Framework 6.1 / Boot 3.2 for full support (Boot 2.7.16+ and 3.1 run on 21). Spring Framework 5.3 supports up to JDK 21, so Spring Boot 2.7 is still possible on this hop but not the next.

## Behavior changes

- **UTF-8 is the default charset** everywhere (JEP 400, JDK 18). Code that relied on the platform default (mostly on Windows) reads and writes files differently. Pass charsets explicitly; `-Dfile.encoding=COMPAT` is the temporary shim.
- **Security Manager** is disallowed by default since JDK 18: `System.setSecurityManager` throws `UnsupportedOperationException` unless `-Djava.security.manager=allow` is set. That escape hatch disappears in JDK 24, so remove the usage now rather than adding the flag.
- **Locale data (CLDR 42, JDK 20):** time formats use a narrow no-break space (U+202F) before AM/PM, and other separators changed. Parsing strings produced by older JDKs fails. Use explicit patterns. `COMPAT` still works on 21 but is removed in 23, so do not lean on it.
- **Sequenced collections (JEP 431):** `List`, `Deque`, `SortedSet` and `LinkedHashMap` gained `getFirst`, `getLast`, `reversed` and friends. Custom collection classes with same-named methods and different return types no longer compile.
- **Dynamic agent loading (JEP 451)** prints a warning (Mockito inline mock maker, Byte Buddy agent, some APM tools). Attach agents with `-javaagent` at startup; for Mockito, add its JAR as `-javaagent` in surefire's `argLine` (OpenRewrite `AddMockitoJavaAgentToMavenSurefirePlugin` does this). `-XX:+EnableDynamicAgentLoading` is the fallback for tests.
- **`Thread.stop()`, `suspend()` and `resume()`** throw `UnsupportedOperationException` (JDK 20). `Thread.stop` is removed entirely in JDK 26.
- Finalization is deprecated for removal; `new URL(...)` and `new Locale(...)` constructors are deprecated (warnings only).
- javac adds the `this-escape` lint warning, which only matters if the build already uses `-Werror`.
- **TLS_RSA cipher suites** are disabled from 21.0.10 (backport of the JDK 24 change). Old endpoints can fail with `SSLHandshakeException` on a 21 patch update, not only on 25.

## Flags to remove

- `--enable-preview` used for features that became final in 21 (pattern matching for switch, record patterns)
- Generational ZGC is opt-in here with `-XX:+ZGenerational`; that flag becomes obsolete in the next hop
