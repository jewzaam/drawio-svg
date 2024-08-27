FROM fedora:latest

COPY drawio-x86_64-24.7.5.rpm /
RUN yum install -y /drawio-x86_64-24.7.5.rpm && yum clean all

RUN yum install -y xeyes && yum clean all

RUN mkdir /drawio
WORKDIR /drawio

COPY gen.sh /drawio/gen.sh
