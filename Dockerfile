FROM openjdk:8u111-jdk
MAINTAINER Christian Hoffmeister <mail@choffmeister.de>

ENV SCALA_VERSION="2.11.8"
ENV SBT_VERSION="0.13.12"
ENV NODE_VERSION="6.9.2"
ENV NPM_VERSION="3.10.9"
ENV DOCKER_VERSION="1.12.3"

WORKDIR /tmp
RUN \
  wget http://downloads.lightbend.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz && \
  echo "490208fdbedaa272276bf338e1cf840e1df15a14  scala-$SCALA_VERSION.tgz" | shasum -c - && \
  tar xf scala-$SCALA_VERSION.tgz && \
  mv scala-$SCALA_VERSION /opt/scala && \
  ln -s /opt/scala/bin/fsc /usr/bin/fsc && \
  ln -s /opt/scala/bin/scala /usr/bin/scala && \
  ln -s /opt/scala/bin/scalac /usr/bin/scalac && \
  ln -s /opt/scala/bin/scaladoc /usr/bin/scaladoc && \
  ln -s /opt/scala/bin/scalap /usr/bin/scalap && \
  rm scala-$SCALA_VERSION.tgz
RUN \
  wget https://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz && \
  echo "df648e18a4e6247661935e8ad358e6f72b777703  sbt-$SBT_VERSION.tgz" | shasum -c - && \
  tar xf sbt-$SBT_VERSION.tgz && \
  ls -al && \
  mv sbt /opt/sbt && \
  ln -s /opt/sbt/bin/sbt /usr/bin/sbt && \
  rm sbt-$SBT_VERSION.tgz && \
  sbt exit
RUN \
  wget https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz && \
  echo "96b6e389d415f95b413dc7ffec7675546b738973  node-v$NODE_VERSION-linux-x64.tar.xz" | shasum -c - && \
  tar xf node-v$NODE_VERSION-linux-x64.tar.xz && \
  mv node-v$NODE_VERSION-linux-x64 /opt/node && \
  ln -s /opt/node/bin/node /usr/bin/node && \
  ln -s /opt/node/bin/npm /usr/bin/npm && \
  rm node-v$NODE_VERSION-linux-x64.tar.xz
RUN \
  wget https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VERSION.tgz && \
  echo "a3bb88649bcc47775c29dab7d95709f4dda04d0e  docker-$DOCKER_VERSION.tgz" | shasum -c - && \
  tar xf docker-$DOCKER_VERSION.tgz && \
  mv docker /opt/docker && \
  ln -s /opt/docker/docker /usr/bin/docker && \
  rm -r docker-$DOCKER_VERSION.tgz

WORKDIR /opt/airfocus
