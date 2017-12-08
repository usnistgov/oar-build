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

# Install build-tools and prerequisite software

# The entrypoint.sh script should accept commands (build, test, bshell,
# shell, etc) as a first argument.  Additional are optional.
#
COPY entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

