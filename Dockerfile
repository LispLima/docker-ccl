FROM ubuntu:14.04
MAINTAINER Mario Rodas <marsam@users.noreply.github.com>

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y wget

ADD . /opt/swankccl
WORKDIR /opt/swankccl

RUN ./bootstrap.sh
EXPOSE 4005
CMD ccl --load start-swank.lisp
