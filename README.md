DIANA xArch Docker Image
==========================

Derek Merck  
<derek_merck@brown.edu>  
Rhode Island Hospital and Brown University  
Providence, RI  

Build multi-arch [DIANA][] and DIANA-Learn Python Docker images for embedded systems.

[DIANA]:https://github.com/derekmerck/diana@diana-star

source: <https://github.com/derekmerck/docker-diana-xarch>


Use It
----------------------

These images are manifested per modern Docker.io guidelines so that an appropriately architected image can be will automatically selected for a given tag depending on the pulling architecture.

```bash
$ docker run derekmerck/diana           # (latest-amd64, latest-arm32v7, latest-arm64v8)
$ docker run derekmerck/diana-learn     # (latest-amd64, latest-arm32v7, latest-arm64v8)
$ docker run derekmerck/diana-movidius  # (latest-arm32v7)
```

Images for specific architectures images can be directly pulled from the same namespace using the format `derekmerck/orthanc:${TAG}-${ARCH}`, where `$ARCH` is one of `amd64`, `arm32v7`, or `arm64v8`.  Explicit architecture specification is sometimes helpful when an indirect build service shadows the production architecture.


Build It
--------------

These images are based on the cross-platform `resin/${ARCH}-debian:stretch` image.  [Resin.io][] base images include the [QEMU][] cross-compiler to facilitate building Docker images for low-power single-board computers while using more powerful Intel-architecture compute servers.

[Resin.io]: http://resin.io
[QEMU]: https://www.qemu.org

This supports builds for `amd64`, `armhf`/`arm32v7`, and `aarch64`/`arm64v8` architectures.  Most low-power single board computers such as the [Raspberry Pi][] and [Beagleboard][] are `armhf`/`arm32v7` devices.  The [Pine64][] and [NVIDIA Jetson][] are `aarch64`/`arm64v8` devices.  Desktop computers/vms, [UP boards][], and the [Intel NUC][] are `amd64` devices.  

[UP boards]: http://www.up-board.org/upcore/
[Intel NUC]: https://www.intel.com/content/www/us/en/products/boards-kits/nuc.html
[Raspberry Pi]: https://www.raspberrypi.org
[Beagleboard]: http://beagleboard.org
[Pine64]: https://www.pine64.org
[NVIDIA Jetson]: https://developer.nvidia.com/embedded/buy/jetson-tx2

`docker-compose.yml` contains build recipes for each architecture for both a simple `diana` image and an `diana-learn` image.  `diana-learn` is based on `diana`, but since we cannot define build dependencies in a compose file (strangely, `depends_on` only works with `run` or `up`), the vanilla `diana` image must be explicitly built before the `diana-learn` image.

To build all images:

1. Register the Docker QEMU cross-compilers
2. Call `docker-compose` to build the vanilla `diana` images
3. Call `docker-compose` to build the `diana-learn` images
4. Get [docker-manifest][] from Github
5. Put Docker into "experimental mode" for manifest creation
6. Call `docker-manifest.py` with an appropriate domain to manifest and push the images

[docker-manifest]: https://github.com/derekmerck/docker-manifest

```bash
$ docker run --rm --privileged multiarch/qemu-user-static:register --reset
$ docker-compose build diana-amd64 diana-arm32v7 diana-arm64v8
$ docker-compose bulid diana-learn-amd64 diana-learn-arm32v7 diana-learn-arm64v8
$ pip install git+https://github.com/derekmerck/docker-manifest
$ mkdir -p $HOME/.docker && echo '{"experimental":"enabled"}' > "$HOME/.docker/config.json"
$ python3 docker-manifest.py --d $DOCKER_USERNAME diana
$ python3 docker-manifest.py --d $DOCKER_USERNAME diana-learn
```

A [Travis][] automation pipeline for git-push-triggered image regeneration and tagging is demonstrated in the `.travis.yml` script.  However, these cross-compiling jobs exceed Travis' 50-minute timeout window, so builds are currently done by hand using cloud infrastructure.

[Travis]: http://travis-ci.org


### TensorFlow

```
curl -O https://storage.googleapis.com/tensorflow-nightly/tensorflow-1.10.0-cp34-none-linux_armv7l.whl
```

The official `arm32` tensorflow wheels are available from pypi or as [nightly build artifacts][tfrpi].  The wheel name for the python 3.4 build has to be manipuated to remove the platform restriction tags in order to install on 3.5 or 3.6.

[tfrpi]: http://ci.tensorflow.org/view/Nightly/

NVIDIA provides a recent [tensorflow wheel for their Jetson TXs][tfjetson].

[tfjetson]: https://devtalk.nvidia.com/default/topic/1031300/tensorflow-1-8-wheel-with-jetpack-3-2-/


### Movidius

The [Intel Movidius][] NPU drivers from the [NCSDK v2.0][] are available in the `diana-movidius` tag.  Only the toolkit itself is installed, tensorflow is from pypi and [caffe][] must be installed separately if needed.

[Intel Movidius]: https://www.movidius.com
[NCSDK v2.0]: https://github.com/movidius/ncsdk
[caffe]: http://caffe.berkeleyvision.org



### DIANA on ARM
 
If you need access to an ARM device for development, [Packet.net][] rents bare-metal 96-core 128GB `aarch64` [Cavium ThunderX] servers for $0.50/hour.  Packet's affiliated [Works On Arm][] program provided compute time for developing and testing these cross-platform images.

[Cavium ThunderX]: https://www.cavium.com/product-thunderx-arm-processors.html
[Packet.net]: https://packet.net
[Works On Arm]: https://www.worksonarm.com

An `arm64v8` image can be built natively and pushed from Packet, using a brief tenancy on a bare-metal Cavium ThunderX ARMv8 server.

```bash
$ apt update && apt upgrade
$ curl -fsSL get.docker.com -o get-docker.sh
$ sh get-docker.sh 
$ docker run hello-world
$ apt install git python-pip
$ pip install docker-compose
$ git clone http://github.com/derekmerck/diana-xarch@system_python
$ cd diana-xarch
$ docker-compose build diana-arm64v8
$ docker-compose build diana-learn-arm64v8
$ python3 manifest-it.py diana-xarch.manifest.yml
```

Although [Resin uses Packet ARM servers to compile arm32 images][resin-on-packet], the available ThunderX does not implement the arm32 instruction set, so it [cannot compile natively for the Raspberry Pi][no-arm32].

[Packet.io]: https://packet.io
[resin-on-packet]: https://resin.io/blog/docker-builds-on-arm-servers-youre-not-crazy-your-builds-really-are-5x-faster/
[no-arm32]: https://gitlab.com/gitlab-org/omnibus-gitlab/issues/2544

Now pull the image tag. You can confirm that the appropriate image has been pulled by starting a container with the command `arch`.  

```bash
$ docker pull derekmerck/orthanc
Using default tag: latest
latest: Pulling from derekmerck/orthanc
Digest: sha256:1975e3a92cf9099284fc3bb2d05d3cf081d49babfd765f96f745cf8a23668ff6
Status: Downloaded newer image for derekmerck/orthanc:latest
$ docker run derekmerck/orthanc arch
aarch64
```

You can also confirm the image architecture without running a container by inspecting the value of `.Config.Labels.architecture`.  (This is a creator-defined label that is _different_ than the normal `.Architecture` key -- which appears to _always_ report as `amd64`.)

```bash
$ docker inspect derekmerck/orthanc --format "{{ .Config.Labels.architecture }}"
arm64v8
```


License
-------

MIT
