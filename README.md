# Basic Keycloak Gatling Load Test

This project is a basic gatling integration for loadtesting keycloak logins.

_**Please note**: The test scenario in this project executes multiple logins for some users, who are a part of a test realm. In order to run this test, some configuration steps listed below must be implemented on your running keycloak server or the `KeycloakLoginSimulator.scala` test scenario must be modified to reflect your realm configurations._

## Installations

You must have the following installed:

- Keycloak version 4.8 which can be downloaded by following the official [keycloak installation guide](https://www.keycloak.org/docs/4.8/getting_started/index.html#_install-boot)

- Scala verion 2.12 which can be downloaded from the [scala-lang website](https://www.scala-lang.org/download/)

- Scala Build Tool (sbt) which can be downloaded using the [Homebrew](https://docs.brew.sh/Installation) command `brew install sbt` on Linux/Unix systems or by following the steps found on the [scala-sbt website](https://www.scala-sbt.org/1.x/docs/Installing-sbt-on-Windows.html) for Windows.

_NOTE: This version of sbt requires java versions 8 or 11 to be installed in order to execute._

## Test Scenario Configurations

### Sbt Proxy Bypass

_NOTE: The following steps are required in order to run this utility on your ISED workstation._

- Open the `sbtconfig.txt` file located in the `Program Files (x86)/sbt/conf` folder.

- Append the following at the end of the file by replacing the [Proxy Host] and [Proxy Port] with the address and port number found in your **Manual proxy setup** (details for which can be found by clicking **Start > Settings > Network & Internet** then accessing the **Proxy** tab on the left hand side of the screen).

```
-Dsbt.log.format=true

-Dhttp.proxyHost=[Proxy Host]

-Dhttp.proxyPort=[Proxy Port]

-Dhttps.proxyHost=[Proxy Host]

-Dhttps.proxyPort=[Proxy Port]
```

### Keycloak Realm Setup

- Boot up keycloak server.
  Steps to this can be found in the [keycloak installation guide](https://www.keycloak.org/docs/4.8/getting_started/index.html#_install-boot).

- Create a new realm titled `load-testing`. _The next few steps must be done within this realm._

- Create a new basic users with username `testaccount` and password `password`

- Create your realm admin user with username `realm-admin` and password `password` and assign them the role of `security-admin-console`

- Modify the client setting for `account` and `security-admin-console` so the **access type** is _public_ and set **Implicit Flow Enabled** to **true** for both clients. _Note: these realm setting changes were made in order to make this basic scala utility test case work. More infromation on this needs to be gathered. For now it seems that keeping the access type to confidential requires an access token to be collected and used post login._

- In the _Manage > Events Config tab_, set the _Save Events_ value to _true_.

## Executing this Test Scenario

- Locate this github project from your terminal and run command `sbt`.
  This should configure the classpath and project settings to your workstation and download all required dependencies.

- Once the sbt interactive build tool has started up run the command `gatling:test`.
  This should run every test case scenarios defined in a scala file located at `/src/test`.
