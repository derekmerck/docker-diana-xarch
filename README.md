DIANA xArch Docker Image
==========================

[![Build Status](https://travis-ci.org/derekmerck/docker-diana-xarch.svg?branch=master)](https://travis-ci.org/derekmerck/docker-diana-xarch)

Derek Merck  
<derek_merck@brown.edu>  
Rhode Island Hospital and Brown University  
Providence, RI  

Build multi-arch [DIANA][] and DIANA-Learn Python Docker images for embedded systems.

[DIANA]:https://github.com/derekmerck/diana

Use It
----------------------

```bash
$ docker run derekmerck/diana:latest
$ docker run derekmerck/diana-learn:latest
```


Build It
--------------

This image is based on the [`derekmerck/conda`][] and `derekmerck/keras-tf` images, which are, in turn, based on the `resin/$ARCH-debian:stretch` image.  [Resin.io][] base images include a [QEMU][] cross-compiler to facilitate building images for low-power single-board computers on more powerful Intel-architecture desktops and servers.

`docker-compose.yml` contains build descriptions for all relevant architectures.

[derekmerck/conda]: https://github.com/derekmerck/docker-conda-xarch
[Resin.io]: http://resin.io
[QEMU]: https://www.qemu.org


### `amd64`

```bash
$ docker-compose build diana-amd64 diana-learn-amd64
```

Desktop computers/vms, [UP boards][], and the [Intel NUC][] are `amd64` devices.  The appropriate image can be built and pushed from [Travis CI][].

[UP boards]: http://www.up-board.org/upcore/
[Intel NUC]: https://www.intel.com/content/www/us/en/products/boards-kits/nuc.html
[Travis CI]: https://travis-ci.org


### `arm32v7`

Most low-power single board computers such as the Raspberry Pi and Beagleboard are `arm32v7` devices.  Appropriate images can be cross-compiled and pushed from Travis CI.

```bash
$ docker-compose build diana-arm32v7 diana-learn-arm32v7
```

[Raspberry Pi]: https://www.raspberrypi.org
[Beagleboard]: https://beagleboard.org


### `arm64v8`
 
The [NVIDIA Jetson TX2][] uses a Tegra `arm64v8` cpu.  The appropriate image can be built natively and pushed from [Packet.io][], using a brief tenancy on a bare-metal Cavium ThunderX ARMv8 server.

```bash
$ apt update && apt upgrade
$ curl -fsSL get.docker.com -o get-docker.sh
$ sh get-docker.sh 
$ docker run hello-world
$ apt install git python-pip
$ pip install docker-compose
$ git clone http://github.com/derekmerck/diana-xarch
$ cd diana-xarch
$ docker-compose build diana-arm64v8 diana-learn-arm64v8
```

Although [Resin uses Packet ARM servers to compile arm32 images][resin-on-packet], the available ThunderX does not implement the arm32 instruction set, so it [cannot compile natively for the Raspberry Pi][no-arm32].

[NVIDIA Jetson TX2]: https://developer.nvidia.com/embedded/buy/jetson-tx2
[Packet.io]: https://packet.io
[resin-on-packet]: https://resin.io/blog/docker-builds-on-arm-servers-youre-not-crazy-your-builds-really-are-5x-faster/
[no-arm32]: https://gitlab.com/gitlab-org/omnibus-gitlab/issues/2544


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
