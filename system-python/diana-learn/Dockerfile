# xArch Diana-Learn System Python Image
# Derek Merck, Summer 2018

ARG DOCKER_ARCH="amd64"
# ARG DOCKER_ARCH="arm32v7"
# ARG DOCKER_ARCH="arm64v8"

FROM diana-$DOCKER_ARCH
LABEL description="X-Arch DIANA-learn"

RUN apt -y update
RUN DEBIAN_FRONTEND=noninteractive apt -y install --no-install-recommends \
    python3-scipy \
    python3-h5py \
    python3-protobuf \
    python3-numpy-dev \
    python3-cffi \
    cython3 \
    libhdf5-dev \
    libatlas-base-dev \
    libopenblas-dev \
    gfortran \
   && apt clean && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-deps --no-cache-dir -U \
    pydot \
    parameterized \
    protobuf \
    absl-py \
    pyparsing

ENV KERAS_BACKEND=tensorflow

RUN pip3 install --no-cache-dir -U \
    tensorflow \
    keras

RUN pip3 install -e /opt/diana/packages/halibut
