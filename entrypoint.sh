#!/bin/bash

## fix for newer debian versions
[ -d /dev/net ] || mkdir -p /dev/net
[ -c /dev/net/tun ] || mknod /dev/net/tun c 10 200

## Use custom pritunl.conf
if [ -n "$PRITUNL_OVERRIDE_CONF" -a -f "$PRITUNL_OVERRIDE_CONF" ]; then
  rm -f /etc/pritunl.conf && ln -s "$PRITUNL_OVERRIDE_CONF" /etc/pritunl.conf
fi

## Specify Mongdb URI via direct variable or via the template variable
if [ -n "$PRITUNL_MONGODB_URI" ]; then
  pritunl set-mongodb $PRITUNL_MONGODB_URI
elif [ -n "$PRITUNL_MONGODB_URI_TEMPLATE" ]; then
  pritunl set-mongodb "$(eval echo -n "$PRITUNL_MONGODB_URI_TEMPLATE")"
fi

exec "$@"
