#!/bin/bash

set -eux -o pipefail

uptime && date

#### Configure System to handle Docker capabilities

# Enable swap accounting for containers
sed -i 's/quiet/quiet cgroup_enable=memory swapaccount=1/' /boot/extlinux.conf

### Install Docker and Compose
apk --no-cache add docker docker-bash-completion docker-compose


# Replace Docker Mirror
mkdir /etc/docker
cat > /etc/docker/daemon.json <<'EOF'
{
    "registry-mirrors": [
        "https://610w9y8k.mirror.aliyuncs.com"
    ],
    "hosts": [
        "tcp://0.0.0.0:2375",
        "unix:///var/run/docker.sock"
    ]
}
EOF

service docker stop
addgroup root docker
addgroup vagrant docker
service docker start
rc-update add docker boot
