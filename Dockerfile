#FROM registry.apps.dev.openshift.ised-isde.canada.ca/ised-ci/<your-base-image>
## Base image containing bash, scala and sbt
FROM hseeberger/scala-sbt:8u212_1.2.8_2.13.0

ENV HOME /home/runner

RUN addgroup -system -gid 10000 runner
RUN adduser -System -uid 10000 -home $HOME -gid 10000 runner

USER root

RUN chmod g=u /etc/passwd

RUN chgrp -R 0 $HOME && chmod -R g=u $HOME

ENV JAR_NAME=idm_keycloak-load-testing_master_2.12-1.0-SNAPSHOT.jar
WORKDIR /home/runner
#copying executables

COPY /$JAR_NAME $JAR_NAME

COPY . . 

# USER runner

EXPOSE 8080

# CMD scala idm_keycloak-load-testing_master_2.12-1.0-SNAPSHOT.jar

CMD sbt

ENTRYPOINT [ "scala", "idm_keycloak-load-testing_master_2.12-1.0-SNAPSHOT.jar" ]

