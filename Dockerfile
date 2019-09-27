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

RUN wget -q https://dl.google.com/go/go${GO_VRSN}.linux-amd64.tar.gz \
  && tar xvf go${GO_VRSN}.linux-amd64.tar.gz \
  && chown -R root:root ./go \
  && mv go /usr/local

RUN  add-apt-repository ppa:git-core/ppa \
  && apt update && apt install git -y

WORKDIR /root

#Doing some cleaning
RUN  rm -r /tools/  \
  && rm -rf /var/lib/apt/lists/*

ENV GOPATH "${HOME}/work"
ENV PATH "${PATH}:/usr/local/go/bin:${GOPATH}/bin"

ENV M2_HOME "/opt/apache-maven"
ENV MAVEN_HOME "/opt/apache-maven"
ENV JAVA_HOME "/usr/lib/jvm/java-11-openjdk-amd64"
ENV PATH "${M2_HOME}/bin:${JAVA_HOME}/bin:${PATH}"

