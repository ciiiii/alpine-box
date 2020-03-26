This builds an up-to-date Vagrant Alpine Linux Base Box.

It contains the base Alpine Linux Image and the one with Docker installed.

Currently this targets [Alpine Linux](https://alpinelinux.org/) 3.11.5

# Usage

## Vagrant up

`vagrant up mayocream/alpine-311-docker`

## Build yourself

Install [Packer](https://www.packer.io/), [Vagrant](https://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/).

```bash
make alpine
# or
make docker
```

## Default settings

The default mirror source is TUNA, and time zone is UTC.

Default user: `root`, Password: `vagrant`

Docker socket at tcp://0.0.0.0:2375, default mirror is Aliyun.

Default disk size is 40Gb.