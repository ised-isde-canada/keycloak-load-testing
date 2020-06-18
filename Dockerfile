#FROM registry.apps.dev.openshift.ised-isde.canada.ca/ised-ci/<your-base-image>
## Base image containing bash, scala and sbt
FROM anapsix/alpine-java

ENV HOME /home/runner
ENV SCALA_VERSION=2.12.10 
ENV SCALA_HOME=/scala

WORKDIR /home/runner

RUN addgroup -S -g 10000 runner
RUN adduser -S -u 10000 -h $HOME -G runner runner

USER root

RUN chmod g=u /etc/passwd

RUN chgrp -R 0 $HOME && chmod -R g=u $HOME

RUN apk add --no-cache --virtual=.build-dependencies wget ca-certificates && \
    apk add --no-cache bash curl jq && \
    cd "/tmp" && \
    wget --no-verbose "https://downloads.typesafe.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" && \
    tar xzf "scala-${SCALA_VERSION}.tgz" && \
    mkdir "${SCALA_HOME}" && \
    rm "/tmp/scala-${SCALA_VERSION}/bin/"*.bat && \
    mv "/tmp/scala-${SCALA_VERSION}/bin" "/tmp/scala-${SCALA_VERSION}/lib" "${SCALA_HOME}" && \
    ln -s "${SCALA_HOME}/bin/"* "/usr/bin/" && \
    apk del .build-dependencies && \
    rm -rf "/tmp/"*

RUN curl -L -o sbt-1.3.3.deb http://dl.bintray.com/sbt/debian/sbt-1.3.3.deb && \
    dpkg -i sbt-1.3.3.deb && \
    rm sbt-1.3.3.deb && \
    apt-get update && \
    apt-get install sbt && \
    sbt sbtVersion

COPY . .

# ENV JAR_NAME=idm_keycloak-load-testing_master_2.12-1.0-SNAPSHOT.jar

CMD sbt

# USER runner

EXPOSE 8080

# CMD scala idm_keycloak-load-testing_master_2.12-1.0-SNAPSHOT.jar

ENTRYPOINT [ "scala", "target/scala-2.12/idm_keycloak-load-testing_master_2.12-1.0-SNAPSHOT.jar" ]