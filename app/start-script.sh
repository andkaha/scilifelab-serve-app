#!/bin/sh -

set -u

# Caddy uses these two directories for persistent storage.
export XDG_CONFIG_HOME="$MY_APP_VOLUME_PATH/xdg/config"
export XDG_DATA_HOME="$MY_APP_VOLUME_PATH/xdg/data"

# Ensure that those directories exist.
install -d "$XDG_CONFIG_HOME"
install -d "$XDG_DATA_HOME"

# This variable points to where the static site is expected to be found.
# Caddy uses this variable in the Caddyfile.
export SITE_ROOT=$MY_APP_VOLUME_PATH/www
install -d "$SITE_ROOT"

printf 'Starting Caddy to serve static content from "%s"\n' \
	"$SITE_ROOT" >&2

exec caddy run --config="$HOME/Caddyfile"
