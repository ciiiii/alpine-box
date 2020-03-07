This builds an up-to-date Vagrant Alpine Linux Base Box.

It contains the base Alpine Linux Image and the one with Docker installed.

Currently this targets [Alpine Linux](https://alpinelinux.org/) 3.11.

# Usage

Install [Packer](https://www.packer.io/), [Vagrant](https://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/).

```bash
make alpine
# or
make docker
```

The default mirror source is TUNA, and time zone is UTC.