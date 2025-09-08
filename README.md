# scilifelab-serve-app

Simple local development scaffold for apps destined for SciLifeLab
Serve.

## Purpose

This repository provides a basic Docker-based environment to run and
test your app locally before deploying to **SciLifeLab Serve**. It
mirrors the structure required by Serve to run a "custom app" using
Docker.

## Demo app

The existing demo app is a minimal web application that serves a static
HTML page from the project's persistent storage volume using Caddy as a
static file server.

This demo app is intended to illustrate the structure and setup required
for deploying an app to SciLifeLab Serve. You can replace the demo
app with your own application by modifying the `Dockerfile` (and
the various other files) in the `app` directory and adjusting the
`scilifelab-compose.yml` file as needed.

To run the demo app:

- Start the project using `./docker-compose.sh up`.  This should pull
  the required Docker image and start the container.  Add `-d` or
  `--detach` to the end of the command to run in the background.

- Access the app at `http://localhost:4157`.  This ought to give you a
  "404 Not Found" message, as the demo app does not have any content in
  its persistent storage volume.

- To add content, place an `index.html` file in the
  `/home/service/vol/www/` directory (the `$APP_VOLUME_PATH/www/`
  directory) in the container while the container is running:
    ```bash
    ./docker-compose.sh exec app mkdir -p /home/service/vol/www/
    ./docker-compose.sh cp app/index.html app:/home/service/vol/www/
    ```

- Refresh the page at `http://localhost:4157` to see your content.

You should also be able to rebuild the app using `./docker-compose.sh
build`, in which case the image will be rebuilt from the `Dockerfile` in
the `app` directory instead of being pulled from the registry.

## Non-servicable parts

The following parts of the setup are not intended to be modified by
the user of this repository:

- `docker-compose.sh`: A wrapper script for `docker compose` that sets
  up the environment and passes the correct arguments to the `docker
  compose` command.   You would use this script instead of calling
  `docker compose` directly.

- `scilifelab-compose.yml`: The Docker Compose configuration file that
  defines the service, the volume, and sets up the necessary ports and
  environment variables.  Note that the Compose file uses a static
  address and port number, `127.0.0.1:4157`, and that it overrids any
  `CMD` or `ENTRYPOINT` defined in the app's `Dockerfile` (it always
  runs `./start-script.sh`).

## Customizable parts

The following parts of the setup are intended to be modified by the
user of this repository to suit their specific app:

- `scilifelab-app.env`: The environment file where you can modify
  a limited set of environment variables to configure "SciLifeLab
  Serve"-specific settings for your app.  This corresponds roughly to
  the settings you would configure in the Serve web interface when
  deploying a custom app.  Adding more variables here will not have
  any effect.

- The `app` directory: This is where you would place your app's
  `Dockerfile` and any other files needed to build your app's Docker
  image.  You can modify the `Dockerfile` to set up your app as
  required.  As previously mentioned, the `CMD` and `ENTRYPOINT`
  instructions in the `Dockerfile` will be overridden by the Compose
  file to always run `./start-script.sh` upon container start.
