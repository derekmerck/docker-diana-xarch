# xArch Diana Conda Python Image
# Derek Merck, Summer 2018

ARG ARCH_TAG="amd64"
#ARG ARCH_TAG="arm32v7"
#ARG ARCH_TAG="arm64v8"

FROM derekmerck/conda:py3-${ARCH_TAG}
MAINTAINER Derek Merck <derek_merck@brown.edu>

RUN mkdir /opt/diana \
    && git clone -b diana-star https://github.com/derekmerck/DIANA /opt/diana \
    && pip3 install -e /opt/diana/packages/guidmint \
                       /opt/diana/packages/diana
