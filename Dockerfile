#FROM registry.apps.dev.openshift.ised-isde.canada.ca/ised-ci/<your-base-image>
## Base image containing bash, scala and sbt
FROM hseeberger/scala-sbt:8u212_1.2.8_2.13.0

ENV HOME /home/runner
WORKDIR /home/runner

RUN addgroup -system -gid 10000 runner
RUN adduser -System -uid 10000 -home $HOME -gid 10000 runner

#copying executables
COPY /target/universal/idm_keycloak-load-testing_master-1.0-SNAPSHOT.zip /home/runner/idm_keycloak-load-testing_master-1.0-SNAPSHOT.zip
RUN ["/usr/bin/unzip", "/home/runner/idm_keycloak-load-testing_master-1.0-SNAPSHOT.zip"]
RUN ["mv", "/home/runner/idm_keycloak-load-testing_master-1.0-SNAPSHOT.zip", "/home/runner/artifacts"]

RUN chmod g+w /etc/passwd
RUN chgrp -Rf root /home/runner && chmod -Rf g+w /home/runner
ENV RUNNER_USER runner

EXPOSE 8080

USER runner

ENTRYPOINT [ "/home/runner/artifacts/bin/idm_keycloak-load-testing_master" ]
