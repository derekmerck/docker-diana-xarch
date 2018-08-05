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
        python3-numpy-dev \
        python3-openssl \
        python3-cffi \
        python3-h5py \
        python3-wheel \
        python3-protobuf \
        cython3 \
        software-properties-common \
        libfreetype6-dev \
        pkg-config \
        libpng-dev \
        libjpeg-dev \
        libsqlite3-dev \
        libssl1.0-dev \
        zlib1g-dev \
        libdcmtk2-dev \
        libgdcm-tools \
        libatlas3-base \
        libhdf5-dev \
        libffi-dev \
    && apt clean && rm -rf /var/lib/apt/lists/*

ENV KERAS_BACKEND=tensorflow

RUN pip3 install -U pip

RUN pip3 install --no-deps --no-cache-dir -U \
        wheel \
        numpy \
        asn1crypto \
        cryptography \
        pyopenssl \
        parameterized \
        pydicom \
        ruamel.yaml \
        pydot \
        pillow \
        scipy \
        h5py \
        pyyaml \
        pillow \
        protobuf \
        absl-py \
        pyparsing

RUN pip3 install --no-deps --no-cache-dir -U \
        tensorflow \
        keras

RUN git clone -b diana-star https://github.com/derekmerck/DIANA /opt/diana \
    && pip3 install -e /opt/diana/packages/guidmint \
                       /opt/diana/packages/diana \
                       /opt/diana/packages/halibut

ENV TZ=America/New_York
# Disable resin.io's systemd init system
ENV INITSYSTEM off

CMD tail -f /dev/null