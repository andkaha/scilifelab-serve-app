#!/bin/sh -

set -u

export XDG_CONFIG_HOME="$APP_VOLUME_PATH/caddy/config"
export XDG_DATA_HOME="$APP_VOLUME_PATH/caddy/data"

install -d "$XDG_CONFIG_HOME"
install -d "$XDG_DATA_HOME"

export SITE_ROOT=$APP_VOLUME_PATH/www

while true; do
	printf 'Starting Caddy to serve static content from "%s"\n' \
		"$SITE_ROOT" >&2

	caddy run --config="$HOME/Caddyfile"

	printf 'Caddy exited with status=%d\n' "$?" >&2
	echo 'Sleeping 30s before restarting...' >&2
	sleep 30
done
