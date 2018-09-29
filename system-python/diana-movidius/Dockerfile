# xArch Diana Movidius Image
# Derek Merck, Summer 2018

ARG DOCKER_ARCH="arm32v7"

FROM diana-learn-${DOCKER_ARCH}
LABEL description="X-Arch DIANA-learn (Movidius)"

RUN apt update \
    && apt install -y --no-install-recommends \
        python3-matplotlib \
        python-dev \
        python-wheel \
        python-pip \
        python-setuptools \
        python-numpy-dev \
        python-openssl \
        python-cffi \
        python-h5py \
        python-scipy \
        python-matplotlib \
    && apt-get clean

RUN pip install --no-deps --no-cache-dir -U \
        wheel \
        numpy \
        scipy \
        h5py \
        pyyaml \
        pillow

RUN git clone -b ncsdk2 https://github.com/movidius/ncsdk /ncsdk2 \
    && sed -i 's/exit 1//g' /ncsdk2/install.sh \
    && sed -i 's/,<=.*//g' /ncsdk2/requirements.txt \
    && sed -i 's/,numpy.*//g' /ncsdk2/requirements.txt \
    && sed -i 's/numpy==/numpy>=/g' /ncsdk2/install.sh
    # Get rid of conflicting numpy max version requirements

COPY ncsdk.conf /ncsdk2/

WORKDIR /ncsdk2
RUN make install