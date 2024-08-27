FROM fedora:latest
COPY drawio-x86_64-24.7.5.rpm /
RUN yum install -y /drawio-x86_64-24.7.5.rpm

RUN useradd -u 1000 drawio

RUN mkdir /drawio
WORKDIR /drawio
RUN chown -R drawio: /drawio

USER drawio

COPY gen.sh /drawio/gen.sh
COPY *.drawio /drawio

