# Welcome to Hue (http://gethue.com) Dockerfile
# Build an image from a remote github or local cloned Hue repository.

FROM ubuntu:20.04
LABEL description="Hue Project https://github.com/cloudera/hue"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get install -y \
  python3-pip \
  libkrb5-dev  \
  libsasl2-modules-gssapi-mit \
  libsasl2-dev \
  libkrb5-dev \
  krb5-config \
  krb5-user \
  libxml2-dev \
  libxslt-dev \
  libmysqlclient-dev \
  libldap2-dev \
  libsnappy-dev \
  python3.8-venv \
  python3.8-dev \
  python3.8-distutils \
  rsync \
  hugo \
  asciidoc \
  curl \
  sudo \
  git && \
  rm -rf /var/lib/apt/lists/*

# Need recent version for Ubuntu
RUN curl -sL https://deb.nodesource.com/setup_20.x | sudo bash - \
    && apt-get install -y nodejs
ENV HOME=/tmp
ENV PATH="$PATH:/tmp/.local/bin"
ENV ROOT=/data
ENV PYTHON_VER=python3.8

