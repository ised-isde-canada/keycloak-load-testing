# FROM anapsix/alpine-java

# ENV SBT_HOME=/sbt
# ENV SBT_VERSION = 1.3.3

# RUN apk add --no-cache --virtual=.build-dependencies wget ca-certificates && \
#     cd "/tmp" && \
#     wget https://piccolo.link/sbt-1.3.3.tgz && \
#     tar -xzvf sbt-1.3.3.tgz && \
#     mkdir "${SBT_HOME}" && \
#     rm "/tmp/${SBT_HOME}/bin/"*.bat && \
#     mv "/tmp/${SBT_HOME}/bin" "/tmp/${SBT_HOME}/lib" "${SBT_HOME}" && \
#     ln -s "${SBT_HOME}/bin/"* "/usr/bin/" && \
#     apk del .build-dependencies && \
#     rm -rf "/tmp/"*

# ENV HOME /home/runner
# WORKDIR /home/runner

# RUN addgroup -S -g 10000 runner
# RUN adduser -S -u 10000 -h $HOME -G runner runner

# COPY target/universal/idm_keycloak-load-testing_master-1.0-SNAPSHOT.zip /home/runner/app.zip

# RUN ["/usr/bin/unzip", "/home/runner/app.zip"]
# RUN ["mv", "/home/runner/idm_keycloak-load-testing_master-1.0-SNAPSHOT", "/home/runner/artifacts"]

# RUN chmod g+w /etc/passwd
# RUN chgrp -Rf root /home/runner && chmod -Rf g+w /home/runner

# ENV RUNNER_USER runner

# EXPOSE 8080

# USER runner

# ENTRYPOINT ["/home/runner/artifacts/bin/idm_keycloak-load-testing_master"]

FROM openshift3/jenkins-slave-base-rhel7

WORKDIR /home/runner

ENV SBT_VERSION 1.3.3
ENV SCALA_VERSION 2.12.10
ENV IVY_DIR=/var/cache/.ivy2
ENV SBT_DIR=/var/cache/.sbt

RUN chmod g+w /etc/passwd
RUN chgrp -Rf root /home/runner && chmod -Rf g+w /home/runner

USER root

RUN INSTALL_PKGS="sbt-$SBT_VERSION" \
    && curl -s https://bintray.com/sbt/rpm/rpm > bintray-sbt-rpm.repo \
    && mv bintray-sbt-rpm.repo /etc/yum.repos.d/ \
    && yum install -y $INSTALL_PKGS \
    && rpm -V $INSTALL_PKGS \
    && yum install -y https://downloads.lightbend.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.rpm \
    && yum list java-1.8.0-openjdk* \
    && yum clean all -y

USER 1001

COPY . .

EXPOSE 8080

ENTRYPOINT ["scala", "target/scala-2.12/idm_keycloak-load-testing_master_2.12-1.0-SNAPSHOT.jar"]