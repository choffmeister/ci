FROM java:8u91-jdk
MAINTAINER Christian Hoffmeister <mail@choffmeister.de>

ENV SCALA_VERSION="2.11.8"
ENV SBT_VERSION="0.13.9"
ENV NODE_VERSION="6.2.2"
ENV NPM_VERSION="3.9.5"
ENV DOCKER_VERSION="1.11.2"

WORKDIR /tmp
RUN \
  wget http://downloads.lightbend.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.deb && \
  echo "1e201e57114ac2d739255cdf80f922ce9bf9682d  scala-$SCALA_VERSION.deb" | shasum -c - && \
  dpkg -i scala-$SCALA_VERSION.deb && \
  rm scala-$SCALA_VERSION.deb
RUN \
  wget https://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz && \
  echo "879ee72d049f1718a29551f55590aa94972f4c96  sbt-$SBT_VERSION.tgz" | shasum -c - && \
  tar xf sbt-$SBT_VERSION.tgz && \
  mv sbt /opt/sbt && \
  ln -s /opt/sbt/bin/sbt /usr/bin/sbt && \
  rm sbt-$SBT_VERSION.tgz && \
  sbt exit
RUN \
  wget https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz && \
  echo "6d1ef19a66d1e0f3c0b1baebbe8c663a55a9015f  node-v$NODE_VERSION-linux-x64.tar.xz" | shasum -c - && \
  tar xf node-v$NODE_VERSION-linux-x64.tar.xz && \
  mv node-v$NODE_VERSION-linux-x64 /opt/node && \
  ln -s /opt/node/bin/node /usr/bin/node && \
  ln -s /opt/node/bin/npm /usr/bin/npm && \
  npm install -g npm@$NPM_VERSION && \
  rm node-v$NODE_VERSION-linux-x64.tar.xz
RUN \
  wget https://get.docker.com/builds/Linux/i386/docker-$DOCKER_VERSION.tgz && \
  echo "bce851f2f096b123332fba5ecae2d9dfdf9e3034  docker-$DOCKER_VERSION.tgz" | shasum -c - && \
  tar -xvzf docker-$DOCKER_VERSION.tgz && \
  mv docker/* /usr/bin/ && \
  rm -r docker-$DOCKER_VERSION.tgz docker/

WORKDIR /opt/airfocus
