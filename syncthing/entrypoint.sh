#!/bin/sh

set -eu

chown "${UID}:${GID}" "${HOME}" \
  && exec su-exec "${UID}:${GID}" \
     env HOME="$HOME" "$@"