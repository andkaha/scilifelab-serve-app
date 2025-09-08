#!/bin/sh -

set -u

export XDG_CONFIG_HOME="$MY_APP_VOLUME_PATH/caddy/config"
export XDG_DATA_HOME="$MY_APP_VOLUME_PATH/caddy/data"

install -d "$XDG_CONFIG_HOME"
install -d "$XDG_DATA_HOME"

export SITE_ROOT=$MY_APP_VOLUME_PATH/www

printf 'Starting Caddy to serve static content from "%s"\n' \
	"$SITE_ROOT" >&2

exec caddy run --config="$HOME/Caddyfile"
