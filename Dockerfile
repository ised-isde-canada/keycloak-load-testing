#FROM registry.apps.dev.openshift.ised-isde.canada.ca/ised-ci/<your-base-image>
## Base image containing bash, scala and sbt
FROM hseeberger/scala-sbt:8u212_1.2.8_2.13.0

ENV HOME /home/runner

RUN addgroup -system -gid 10000 runner
RUN adduser -System -uid 10000 -home $HOME -gid 10000 runner

USER root

RUN chmod g=u /etc/passwd

RUN chgrp -R 0 $HOME && chmod -R g=u $HOME

WORKDIR /home/runner
#copying executables
COPY /target/universal/idm_keycloak-load-testing_master-1.0-SNAPSHOT.zip $HOME/idm_keycloak-load-testing_master-1.0-SNAPSHOT.zip
RUN unzip idm_keycloak-load-testing_master-1.0-SNAPSHOT.zip
RUN ls -la
RUN mv idm_keycloak-load-testing_master-1.0-SNAPSHOT /artifacts
RUN rm idm_keycloak-load-testing_master-1.0-SNAPSHOT.zip

# USER runner

EXPOSE 8080

ENTRYPOINT [ "idm_keycloak-load-testing_master-1.0-SNAPSHOT" ]
