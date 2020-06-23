FROM anapsix/alpine-java

ENV SBT_HOME=usr/sbt
ENV SBT_VERSION = 1.3.3

RUN apk add --no-cache --virtual=.build-dependencies wget ca-certificates && \
    cd "/tmp/" && \
    wget https://piccolo.link/sbt-1.3.3.tgz && \
    tar -xzvf sbt-1.3.3.tgz && \
    mv "/tmp/${SBT_HOME}/bin" "/tmp/${SBT_HOME}/lib" "${SBT_HOME}" && \
    ln -s "${SBT_HOME}/bin/"* "/usr/bin/" && \
    apk del .build-dependencies && \
    rm -rf "/tmp/"*

ENV HOME /home/runner
WORKDIR /home/runner

RUN addgroup -S -g 10000 runner
RUN adduser -S -u 10000 -h $HOME -G runner runner

COPY target/universal/idm_keycloak-load-testing_master-1.0-SNAPSHOT.zip /home/runner/app.zip

RUN ["/usr/bin/unzip", "/home/runner/app.zip"]
RUN ["mv", "/home/runner/idm_keycloak-load-testing_master-1.0-SNAPSHOT", "/home/runner/artifacts"]

RUN chmod g+w /etc/passwd
RUN chgrp -Rf root /home/runner && chmod -Rf g+w /home/runner

ENV RUNNER_USER runner

EXPOSE 8080

USER runner

ENTRYPOINT ["/home/runner/artifacts/bin/idm_keycloak-load-testing_master"]

