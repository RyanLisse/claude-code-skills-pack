# Library and tool minimums per JDK

Lowest versions known to work on each target JDK. Prefer the newest patch within the project's current major. Verify against release notes before pinning: rows marked *derived* were inferred from dependency versions, not stated by the project.

Last checked: 2026-09-30.

| Component | JDK 11 | JDK 17 | JDK 21 | JDK 25 | Notes |
|---|---|---|---|---|---|
| Gradle (to run on the JDK) | 5.0 | 7.3 | 8.5 | 9.1.0 | Gradle 9 itself needs JDK 17+ to run |
| Maven | 3.6.3 | 3.8.x | 3.9.x | 3.9.x | Plugins matter more than core |
| maven-compiler-plugin | 3.8.0 | 3.8.1 | 3.11.0 | 3.14.1 *recommended* | No official minimum for 25 |
| maven-surefire / failsafe | 2.22.x | 3.0.x | 3.1.x | 3.5.4 *recommended* | Keep `@{argLine}` when setting `argLine` |
| ASM | 7.0 | 9.1 | 9.5 | 9.8 | |
| Byte Buddy | 1.9 | 1.11 | 1.14.x | 1.17.5 | Prefer 1.17.7+ on 25 |
| Lombok | 1.18.4 | 1.18.22 | 1.18.30 | 1.18.40 (use 1.18.42+) | 1.18.40 stopped copying Jackson annotations to accessors; restore with `lombok.copyJacksonAnnotationsToAccessors = true` |
| Mockito | 2.23 | 4.x | 5.x | 5.19+ *derived* | Mockito 5 needs Java 11 at runtime; 5.17 fails on 25 |
| PowerMock | 2.0 | not reliable | not reliable | not reliable | Replace with Mockito inline mocking |
| JaCoCo | 0.8.2 | 0.8.7 | 0.8.11 | 0.8.14 | 0.8.13 only had experimental 25 support |
| Groovy | 2.5.x | 3.0.9 | 4.0.x | 5.0 (4.0.27 partial) | |
| Kotlin | 1.3.x | 1.6 | 1.9.20 | 2.3.0 | Older Kotlin falls back to JVM 24 bytecode |
| SpotBugs | 4.0 | 4.4 | 4.8 | 4.9.7 | |
| Spring Framework | 5.1 | 5.3 | 6.1 (5.3 runs) | 6.2 / 7.x | 5.3 supports JDK 8–21 |
| Spring Boot | 2.1 | 2.5.5 | 3.2 (2.7.16+ runs) | 3.5.5+ / 4.0 | Boot 3+ requires JDK 17 and `jakarta.*` |
| Tomcat | 8.5 / 9 | 9.0.x | 10.1 / 9.0.x | 10.1 / 11 | |

JDK 11–21 values for Byte Buddy 1.14.x, Kotlin, SpotBugs, Tomcat and the Maven plugin rows come from general knowledge and were not re-verified on 2026-09-30.

Sources: Lombok changelog; JaCoCo change history; ASM versions page; Byte Buddy release notes; Mockito releases; Gradle compatibility matrix and 9.1.0 release notes; Kotlin "What's new in 2.3.0"; Groovy 5.0 release notes; SpotBugs issue #3564; Spring Framework Versions wiki; Spring Boot 3.5 system requirements and issue #47245.
