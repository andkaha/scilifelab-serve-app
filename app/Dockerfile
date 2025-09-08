FROM alpine:latest

ARG MY_APP_USER
ARG APP_PORT
ARG APP_VOLUME_PATH

ARG UID=1000
RUN adduser -D -u "$UID" "$MY_APP_USER"

RUN --mount=type=cache,id=apk-cache,target=/etc/apk/cache \
	apk add caddy

WORKDIR "/home/${MY_APP_USER?}"

USER "$UID"

ENV APP_PORT=${APP_PORT?}
ENV APP_VOLUME_PATH=${APP_VOLUME_PATH?}

COPY --chown=$UID --chmod=444 ./Caddyfile ./Caddyfile
COPY --chown=$UID --chmod=555 ./start-script.sh ./start-script.sh

RUN install -d -o "$UID" "$APP_VOLUME_PATH"

EXPOSE $APP_PORT

CMD [ "./start-script.sh" ]
