FROM alpine:latest
MAINTAINER racohen

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update && apk add screen telegraf@testing
RUN mkdir -p /etc/telegraf  

COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf
COPY srcs/start-telegraf.sh /bin/startscript/start-telegraf.sh
