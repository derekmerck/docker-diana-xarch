# xArch Diana System Python Image
# Derek Merck, Summer 2018

ARG RESIN_ARCH="intel-nuc"
#ARG RESIN_ARCH="raspberrypi3"
#ARG RESIN_ARCH="jetson-tx2"

FROM resin/${RESIN_ARCH}-debian:stretch
MAINTAINER Derek Merck <derek_merck@brown.edu>

RUN apt update \
    && apt upgrade \
    && apt install -y --no-install-recommends \
        git \
        sed \
        build-essential \
        sudo \
        tar \
        udev \
        wget \
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

#RUN pip3 install --no-deps --no-cache-dir -U \
#        tensorflow \
#        keras

RUN mkdir /opt/diana \
    && git clone -b diana-star https://github.com/derekmerck/DIANA /opt/diana \
    && pip3 install -e /opt/diana/packages/guidmint \
                       /opt/diana/packages/diana

ENV TZ=America/New_York
# Disable resin.io's systemd init system
ENV INITSYSTEM off

CMD tail -f /dev/null
