FROM ubuntu:xenial

### Install necessary packages

# Add Mesosphere repository
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E56151BF && echo deb http://repos.mesosphere.io/ubuntu xenial main > /etc/apt/sources.list.d/mesosphere.list

# Install required libraries including mesos for the libmesos
RUN apt-get update && apt-get -y install curl openjdk-8-jre-headless mesos=1.5.1-2.0.2 python2.7

### Environment variables
ENV JAVA_HOME='/usr/lib/jvm/java-8-openjdk-amd64'

## Environment variables control the behavior of the Mesos scheduler driver (libmesos).
ENV LIBPROCESS_PORT=8083 GLOG_v=0

## Flags that control the behavior of the JVM.
ENV JAVA_OPTS='-Djava.library.path=/usr/local/lib'

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]