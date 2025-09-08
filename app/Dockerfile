FROM alpine:latest

ARG MY_APP_USER=service
ARG MY_APP_PORT=8000
ARG MY_APP_VOLUME_PATH=/home/$MY_APP_USER/vol

RUN --mount=type=cache,id=apk-cache,target=/etc/apk/cache \
	apk add caddy

ARG UID=1000
RUN adduser -D -u "$UID" "$MY_APP_USER"

WORKDIR "/home/${MY_APP_USER?}"

USER "$UID"

ENV MY_APP_PORT=${MY_APP_PORT?}
ENV MY_APP_VOLUME_PATH=${MY_APP_VOLUME_PATH?}

COPY --chown=$UID --chmod=444 ./Caddyfile ./Caddyfile
COPY --chown=$UID --chmod=555 ./start-script.sh ./start-script.sh

RUN install -d -o "$UID" "$MY_APP_VOLUME_PATH"

EXPOSE $MY_APP_PORT
