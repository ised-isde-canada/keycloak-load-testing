#FROM registry.apps.dev.openshift.ised-isde.canada.ca/ised-ci/<your-base-image>
## Base image containing bash, scala and sbt
FROM hseeberger/scala-sbt:8u212_1.2.8_2.13.0

ENV HOME /home/runner

RUN addgroup -system -gid 10000 runner
RUN adduser -System -uid 10000 -home $HOME -gid 10000 runner

USER root

RUN chmod g=u /etc/passwd

RUN chgrp -R 0 $HOME && chmod -R g=u $HOME

ENV ZIP_NAME=idm_keycloak-load-testing_master-1.0-SNAPSHOT.zip
WORKDIR /home/runner
#copying executables
COPY /target/universal/$ZIP_NAME $ZIP_NAME
RUN unzip $ZIP_NAME && \
    mv idm_keycloak-load-testing_master-1.0-SNAPSHOT /artifacts && \
    rm $ZIP_NAME

# USER runner

EXPOSE 8080

ENTRYPOINT [ "/home/runner/artifacts/bin/idm_keycloak-load-testing_master" ]

