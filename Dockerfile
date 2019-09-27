FROM ubuntu:latest

ARG GO_VRSN=1.13.1

WORKDIR /tools

RUN apt-get update && apt-get install -y \
    software-properties-common \
    apt-transport-https \
    wget \
    unzip \
    tree \
    curl \
    vim


RUN  add-apt-repository ppa:git-core/ppa \
  && apt update && apt install git -y

RUN wget -q https://dl.google.com/go/go${GO_VRSN}.linux-amd64.tar.gz \
  && tar xvf go${GO_VRSN}.linux-amd64.tar.gz \
  && chown -R root:root ./go \
  && mv go /usr/local 

WORKDIR /root/work

#Doing some cleaning
RUN  rm -r /tools/  \
  && rm -rf /var/lib/apt/lists/*

ENV HOME  "/root"
ENV GOPATH "${HOME}/work"
ENV PATH "${PATH}:/usr/local/go/bin:${GOPATH}/bin"

RUN go get -u github.com/rakyll/hey
