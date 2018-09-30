# xArch Diana System Python Image
# Derek Merck, Summer 2018

ARG RESIN_ARCH="amd64"
#ARG RESIN_ARCH="armv7hf"
#ARG RESIN_ARCH="aarch64"

FROM resin/${RESIN_ARCH}-debian:buster

ARG DOCKER_ARCH="amd64"
# ARG DOCKER_ARCH="arm32v7"
# ARG DOCKER_ARCH="arm64v8"

LABEL maintainer="Derek Merck"
LABEL email="derek_merck@brown.edu"
LABEL description="X-Arch DIANA"
LABEL vendor="Rhode Island Hospital"
LABEL architecture="$DOCKER_ARCH"
LABEL os="linux"

RUN apt -y clean && apt -y update && apt -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt -y install --no-install-recommends \
    wget \
    nano \
    git \
    sed \
    build-essential \
    sudo \
    tar \
    udev \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-openssl \
    python3-wheel \
    software-properties-common \
    libfreetype6-dev \
    pkg-config \
    libpng-dev \
    libjpeg-dev \
    libsqlite3-dev \
    libssl1.0-dev \
    zlib1g-dev \
    libgdcm-tools \
    libffi-dev \
  && apt clean && rm -rf /var/lib/apt/lists/*

RUN pip3 install -U pip

RUN pip3 install --no-deps --no-cache-dir -U \
    wheel \
    beautifulsoup4 \
    asn1crypto \
    cryptography \
    pyopenssl \
    pydicom \
    requests \
    ruamel.yaml \
    pillow \
    pyyaml

RUN mkdir /opt/diana \
    && git clone -b diana-star https://github.com/derekmerck/DIANA /opt/diana \
    && pip3 install -e /opt/diana/packages/guidmint \
                       /opt/diana/packages/diana

# Leave entrypoint alone for resin-init
CMD ["tail", "-f", "/dev/null"]

ENV TZ=America/New_York
# Disable resin.io's systemd init system
ENV INITSYSTEM off
