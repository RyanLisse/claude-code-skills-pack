# Hop: Java 8 → 11

Class file major version 55. Tooling to run on 11: Maven 3.6.3+, Gradle 5.0+ (prefer 7.x/8.x). OpenRewrite recipe: `Java8toJava11` (run on JDK 8).

## Removed from the JDK

Add explicit dependencies only for what the code uses. The 2.3.x / 1.x Jakarta artifacts below still use the `javax.*` packages, so no code changes are needed; the switch to `jakarta.*` packages (3.x+) is a separate migration.

| Missing package | Add |
|---|---|
| `javax.xml.bind` | `jakarta.xml.bind:jakarta.xml.bind-api:2.3.3` + `org.glassfish.jaxb:jaxb-runtime:2.3.x` (runtime) |
| `javax.annotation` (`@PostConstruct`, `@PreDestroy`, `@Generated`, `@Resource`) | `jakarta.annotation:jakarta.annotation-api:1.3.5` |
| `javax.activation` | `jakarta.activation:jakarta.activation-api:1.2.2` |
| `javax.xml.ws`, `javax.jws` | `com.sun.xml.ws:jaxws-rt:2.3.x` |
| `javax.transaction` | `jakarta.transaction:jakarta.transaction-api:1.3.3` |
| `javafx.*` | `org.openjfx:javafx-*` with platform classifiers, plus the JavaFX Maven/Gradle plugin |
| `org.omg.*` (CORBA) | No drop-in replacement. Stop and raise with the user. |

If a framework BOM (Spring Boot, etc.) manages these versions, omit the version.

Also gone:

- `xjc`, `wsimport`, `schemagen` from the JDK: use `jaxb2-maven-plugin` / `jaxws-maven-plugin` or Gradle equivalents
- Java Web Start, applets, `sun.misc.BASE64Encoder/Decoder` (use `java.util.Base64`)
- `tools.jar`, `rt.jar`, endorsed and extension directories (the JVM refuses to start if those properties are set)

Find usages:

```bash
grep -rEn "import (javax\.(xml\.bind|xml\.ws|jws|annotation\.(PostConstruct|PreDestroy|Generated|Resource)|activation|transaction)|org\.omg|javafx)\." --include=*.java .
grep -rEn "sun\.misc\.|sun\.reflect\.|tools\.jar|rt\.jar|java\.endorsed\.dirs|java\.ext\.dirs|java\.version|URLClassLoader" .
```

## Library minimums

See `library-matrix.md`. Highlights: ASM 7, Byte Buddy 1.9, Lombok 1.18.4, Mockito 2.23, JaCoCo 0.8.2, PowerMock 2.0. Spring Framework 5.1 / Boot 2.1 for official support; Spring 4.3 often runs but is unsupported on 11: flag it as a risk, do not upgrade the major here. Mockito 5 needs Java 11 at runtime, so move to it only after the switch.

## Behavior changes

- **Illegal reflective access** is only a warning on 11 but becomes an error in the next hop. Fix it now by upgrading libraries.
- **CLDR locale data** is the default: date, number and currency formats and week rules change. Make formats explicit in code and tests; `-Djava.locale.providers=COMPAT,CLDR` is a temporary shim that stops working in JDK 23.
- **`java.version`** is `11.0.x`, not `1.8.0_x`; fix any parsing in code and shell scripts.
- **The system class loader** is no longer a `URLClassLoader`; casts throw `ClassCastException`.
- **TLS 1.3** is enabled. Test legacy endpoints; pin with `-Djdk.tls.client.protocols=TLSv1.2` only if needed, and document it.
- **Default keystore type** is PKCS12 (since 9); existing JKS files still load.
- **Containers:** the JVM reads cgroup limits. Prefer `-XX:MaxRAMPercentage`.
- **G1** is the default GC; re-check heap settings tuned for Parallel GC.

## Flags to remove or replace

- `-XX:+PrintGCDetails`, `-XX:+PrintGCDateStamps`, `-Xloggc:`, `-XX:+UseGCLogFileRotation` → `-Xlog:gc*:file=gc.log:time,uptime,level,tags:filecount=5,filesize=20m`
- `-XX:PermSize`, `-XX:MaxPermSize`, `-Djava.endorsed.dirs`, `-Djava.ext.dirs`, `-Xbootclasspath/p:` (only `/a:` remains)
- `-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap`

Nashorn and Pack200 are deprecated in 11 but still work; they are removed in the next hop, so list their use as a risk.
