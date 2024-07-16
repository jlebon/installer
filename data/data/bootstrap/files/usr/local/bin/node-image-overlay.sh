#!/bin/bash
set -euo pipefail

ostree_repo=/var/ostree-container/repo
if [ ! -d "${ostree_repo}" ]; then
    ostree_repo=/ostree/repo
fi

checkout="${ostree_repo}/tmp/node-image"

# keep /usr/lib/modules from the booted deployment for kernel modules
mount -o bind,ro "/usr/lib/modules" "${checkout}/usr/lib/modules"
mount -o rbind,ro "${checkout}/usr" /usr
rsync -av "${checkout}/usr/etc/" /etc

# reload the new policy
semodule -R
