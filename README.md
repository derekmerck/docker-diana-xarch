DIANA xArch Docker Image
==========================

[![Build Status](https://travis-ci.org/derekmerck/docker-diana-xarch.svg?branch=master)](https://travis-ci.org/derekmerck/docker-diana-xarch)

Derek Merck  
<derek_merck@brown.edu>  
Rhode Island Hospital and Brown University  
Providence, RI  

Build multi-arch [DIANA][] and DIANA-Learn Python Docker images for embedded systems.

[DIANA]:https://github.com/derekmerck/diana@system-python

Use It
----------------------

```bash
$ docker run derekmerck/diana:latest    # (amd64, arm32v7, arm64v8)
$ docker run derekmerck/diana:learn     # (learn-amd64, learn-arm32v7, learn-arm64v8)
$ docker run derekmerck/diana:movidius  # (movidius-arm32v7)
```

Build It
--------------

This image uses system python and the `resin/$ARCH-debian:stretch` image.  [Resin.io][] base images include a [QEMU][] cross-compiler to facilitate building images for low-power single-board computers on more powerful Intel-architecture desktops and servers.

`docker-compose.yml` contains build descriptions for all relevant architectures.

[derekmerck/conda]: https://github.com/derekmerck/docker-conda-xarch
[Resin.io]: http://resin.io
[QEMU]: https://www.qemu.org


### `amd64`

```bash
$ docker-compose build diana-amd64
```

Desktop computers/vms, [UP boards][], and the [Intel NUC][] are `amd64` devices.  The appropriate image can be built and pushed from [Travis CI][].

[UP boards]: http://www.up-board.org/upcore/
[Intel NUC]: https://www.intel.com/content/www/us/en/products/boards-kits/nuc.html
[Travis CI]: https://travis-ci.org


### `arm32v7`

Most low-power single board computers such as the Raspberry Pi and Beagleboard are `arm32v7` devices.  Appropriate images can be cross-compiled and pushed from Travis CI.

```bash
$ docker-compose build diana-arm32v7 diana-movidius-arm32v7
```

[Raspberry Pi]: https://www.raspberrypi.org
[Beagleboard]: https://beagleboard.org

The official `arm32` tensorflow wheels are available from pypi or as [nightly build artifacts][tfrpi].  The wheel name for the python 3.4 build has to be manipuated to remove the platform restriction tags to install on 3.5 or 3.6.

[tfrpi]: http://ci.tensorflow.org/view/Nightly/

The [Intel Movidius][] NPU drivers from the [NCSDK v2.0][] are available in the `diana:movidius` tag.  Only the toolkit itself is installed, tensorflow is from pypi and [caffe][] must be installed separately.

[Intel Movidius]: https://www.movidius.com
[NCSDK v2.0]: https://github.com/movidius/ncsdk
[caffe]: http://caffe.berkeleyvision.org

### `arm64v8`
 
The [NVIDIA Jetson TX2][] uses a Tegra `arm64v8` cpu.  Appropriate images can be cross-compiled and pushed from Travis CI.

```bash
$ docker-compose build diana-arm64v8
```

Although [Resin uses Packet ARM servers to compile arm32 images][resin-on-packet], the available ThunderX does not implement the arm32 instruction set, so it [cannot compile natively for the Raspberry Pi][no-arm32].

[NVIDIA Jetson TX2]: https://developer.nvidia.com/embedded/buy/jetson-tx2
[Packet.io]: https://packet.io
[resin-on-packet]: https://resin.io/blog/docker-builds-on-arm-servers-youre-not-crazy-your-builds-really-are-5x-faster/
[no-arm32]: https://gitlab.com/gitlab-org/omnibus-gitlab/issues/2544

NVIDIA provides a recent [tensorflow wheel for their Jetson TXs][tfjetson].

[tfjetson]: https://devtalk.nvidia.com/default/topic/1031300/tensorflow-1-8-wheel-with-jetpack-3-2-/

Manifest It
----------------

After building new images, call `manifest-it.py` to push updated images and build the Docker
multi-architecture service mappings.

```bash
$ python3 manifest-it diana-xarch.manifest.yml
```


License
-------

MIT
