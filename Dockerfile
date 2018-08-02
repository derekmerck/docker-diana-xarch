# xArch Diana Image
# Derek Merck, Summer 2018

ARG ARCH="amd64"

FROM derekmerck/conda:py3-${ARCH}
MAINTAINER Derek Merck <derek_merck@brown.edu>

RUN apt-get update && apt-get install -yq --no-install-recommends \
        git \
        libgcdm-tools \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN conda install pillow

RUN git clone -b diana-star https://github.com/derekmerck/DIANA /usr/share/source/diana \
    && pip install -e /usr/share/source/diana/packages/guidmint /usr/share/source/diana/packages/diana

ENV TZ=America/New_York
# Disable resin.io's systemd init system
ENV INITSYSTEM off

CMD tail -f /dev/null
