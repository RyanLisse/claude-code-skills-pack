# Troubleshooting

Symptom → cause → fix. Check whether the failure also happens on the baseline JDK before fixing it.

| Symptom | Cause | Fix |
|---|---|---|
| `Unsupported class file major version NN` | A bytecode tool or the build tool is too old for this JDK (55=11, 61=17, 65=21, 69=25) | Upgrade ASM, Byte Buddy, JaCoCo, Gradle, SpotBugs per `library-matrix.md` |
| `Unrecognized VM option` / `Could not create the Java Virtual Machine` | Removed flag | Run `scripts/scan-flags.sh`; see the hop's flag list |
| `NoClassDefFoundError: javax/xml/bind/...` or `javax/annotation/...` | Java EE module removed in 11 | Add the dependency from `hop-8-to-11.md`; if OpenRewrite ran on 11+, it may have skipped this (issue #1246) |
| `package javax.xml.bind does not exist` only in generated sources | JDK `xjc`/`wsimport` gone | Use the Maven/Gradle JAXB and JAX-WS plugins |
| `InaccessibleObjectException ... does not "opens"` | Strong encapsulation (17+) | Upgrade the library; else targeted `--add-opens`, documented |
| `ClassCastException ... cannot be cast to URLClassLoader` | System class loader changed in 9 | Upgrade the library; read `java.class.path` instead |
| Lombok getters or MapStruct mappers missing at compile time | Lombok too old, or implicit annotation processing disabled (23+) | Upgrade Lombok; declare processors in `annotationProcessorPaths` / `annotationProcessor` |
| `TypeTag :: UNKNOWN` with Lombok on 25 | Lombok below 1.18.42 | Upgrade Lombok |
| Coverage drops to zero or surefire fork crashes | `argLine` overwrote JaCoCo's agent, or old surefire | Keep `@{argLine}`; upgrade surefire |
| Date, time or number assertions fail | CLDR locale data changed (9, 20, 23) | Use explicit patterns; `COMPAT` is gone in 23 |
| Garbled non-ASCII text on 18+ | UTF-8 default charset | Pass charsets explicitly |
| NPE message assertions fail on 17 | Helpful NPE messages | Assert on type, not message |
| `SSLHandshakeException` | TLS 1.0/1.1 disabled (17), TLS_RSA suites disabled (24, 21.0.10) | Debug with `-Djavax.net.debug=ssl:handshake`; fix the endpoint |
| `UnsupportedOperationException` from `setSecurityManager` | Disallowed since 18, permanently disabled in 24 | Remove the usage |
| `WARNING: A Java agent has been loaded dynamically` | JEP 451 (21) | Attach with `-javaagent`; `-XX:+EnableDynamicAgentLoading` in tests as fallback |
| `WARNING: A terminally deprecated method in sun.misc.Unsafe has been called` | JEP 498 (24) | Upgrade the library; `--sun-misc-unsafe-memory-access=allow` temporarily |
| `WARNING: A restricted method in java.lang.System has been called` | JNI warning, JEP 472 (24) | `--enable-native-access=ALL-UNNAMED` for the library that needs it |
| Custom collection no longer compiles on 21 (`getFirst`, `reversed`) | Sequenced collections | Rename or align the method signature |
| `reference to Record is ambiguous` | `java.lang.Record` (16+) | Explicit import |
| Gradle: "maximum compatible Gradle JVM is 24" in the IDE | IDE older than the Gradle/JDK combination | Update the IDE; the CLI build is authoritative |
