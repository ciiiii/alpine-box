#!/bin/sh
set -ux # No -e flag for the dd case

rm -rf /tmp/* /var/log/* /var/cache/apk/*

# zero the free disk space -- for better compression of the box file.
dd if=/dev/zero of=/EMPTY bs=1M || true && sync && rm -f /EMPTY && sync

exit 0