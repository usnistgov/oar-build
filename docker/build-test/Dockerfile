# build-test/Dockerfile -- a container for buildin and testing this package's
#                          build products

# Pick a base image
#
# FROM mongo:3.4.2
# FROM openjdk:8-jdk-alpine
FROM ubuntu:latest

# Set the name of the package
#
ENV PACKAGE_NAME=oar-build

RUN mkdir -p /dev/$PACKAGE_NAME
WORKDIR /dev/$PACKAGE_NAME

###
#
# See INSTALL PREREQUISITES  below for the location to add code to
# install build tools and prerequisite software.
#
###

ARG devuser=developer
ARG devuid=1000

RUN apt-get update && apt-get install -y zip wget curl

ENV GOSU_VERSION 1.10
RUN set -ex; \
    arch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
    wget -O /usr/local/bin/gosu \
   "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$arch"; \
    wget -O /usr/local/bin/gosu.asc \
"https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$arch.asc";\
    export GNUPGHOME="$(mktemp -d)"; \
    gpg --keyserver ha.pool.sks-keyservers.net \
         --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
    gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
    rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc; \
    chmod +x /usr/local/bin/gosu; \
    gosu nobody true

# Create the user that build/test operations should run as.  Normally,
# this is set to match identity information of the host user that is
# launching the container.
#
RUN sed --in-place -e '/CREATE_MAIL_SPOOL/ s/=yes/=no/' /etc/default/useradd
ARG devuser=developer
ARG devuid=1000
RUN grep -qs :${devuid}: /etc/group || \
    groupadd --gid $devuid $devuser
RUN grep -Pqs ":${devuid}:\d+:" /etc/passwd || \
    useradd -m --comment "OAR Developer" --shell /bin/bash \
            --gid $devuid --uid $devuid $devuser

# Install build-tools and prerequisite software

# The entrypoint.sh script should accept commands (build, test, bshell,
# shell, etc) as a first argument.  Additional are optional.
#
COPY entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
ENTRYPOINT ["/usr/loca/bin/gosu", "developer", "/entrypoint.sh"]

