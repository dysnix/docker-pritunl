#!/bin/bash

## Specify Mongdb URI via direct variable or via the template variable
if [ -n "$PRITUNL_MONGODB_URI" ]; then
  pritunl set-mongodb $PRITUNL_MONGODB_URI
elif [ -n "$PRITUNL_MONGODB_URI_TEMPLATE" ]; then
  pritunl set-mongodb $(eval echo -n "$PRITUNL_MONGODB_URI_TEMPLATE")
fi

exec "$@"
