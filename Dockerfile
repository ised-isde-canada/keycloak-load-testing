#FROM registry.apps.dev.openshift.ised-isde.canada.ca/ised-ci/<your-base-image>
## Base image containing bash, scala and sbt
FROM adoptopenjdk/openjdk8

ENV HOME /home/runner
WORKDIR /home/runner

COPY . .

RUN addgroup -system -gid 10000 runner
RUN adduser -System -uid 10000 -home $HOME -gid 10000 runner

USER root

RUN chmod g=u /etc/passwd

RUN chgrp -R 0 $HOME && chmod -R g=u $HOME

# Install sbt & scala
# RUN curl -L -o sbt-1.3.3.deb http://dl.bintray.com/sbt/debian/sbt-1.3.3.deb && \
#     dpkg -i sbt-1.3.3.deb && \
#     rm sbt-1.3.3.deb && \
#     apt-get update && \
#     apt-get install sbt && \
#     sbt sbtVersion

RUN    curl -L -o scala-2.12.10.deb https://www.scala-lang.org/files/archive/scala-2.12.10.deb && \
    dpkg -i scala-2.12.10 && \
    rm scala-2.12.10 && \
    scala -version

ENV JAR_NAME=idm_keycloak-load-testing_master_2.12-1.0-SNAPSHOT.jar

#copying executables

# USER runner

EXPOSE 8080

# CMD scala idm_keycloak-load-testing_master_2.12-1.0-SNAPSHOT.jar

ENTRYPOINT [ "scala", "target/scala-2.12/idm_keycloak-load-testing_master_2.12-1.0-SNAPSHOT.jar" ]