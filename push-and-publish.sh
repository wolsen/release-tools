#!/bin/bash

set -e

series="$2"
charm="$1"

charm_url="cs:~openstack-charmers/$series/$charm"

charm_ref="$(charm push $charm $charm_url | grep url | awk '{ print $2 }')"
if [ -z "$charm_ref" ]; then
    echo "Failed to push charm to charm-store"
    exit 1
fi

charm set $charm_url bugs-url=https://bugs.launchpad.net/charms/+source/$charm/+filebug \
    homepage=https://github.com/openstack/charm-$charm
charm publish $charm_ref
charm grant $charm_url --acl read everyone