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
for deploying an app to SciLifeLab Serve. You can replace the demo app
with your own application by modifying the `Dockerfile` (various other
files) in the `app` directory and adjusting the `scilifelab-compose.yml`
file as needed.

To run the demo app:

- Start the project using `./docker-compose.sh up`.  This should pull
  the required Docker image and start the container.  Add `-d` or
  `--detach` to the end of the command to run in the background.

- Access the app at `http://localhost:4157`.  This ought to give you a
  "404 Not Found" message, as the demo app does not have any content in
  its persistent storage volume.

- To add content, place an `index.html` file in the
  `/home/service/vol/www/` directory in the container while the
  container is running:
    ```bash
    ./docker-compose.sh exec app mkdir -p /home/service/vol/www/
    ./docker-compose.sh cp app/index.html app:/home/service/vol/www/
    ```

- Refresh the page at `http://localhost:4157` to see your content.

You should also be able to rebuild the app using `./docker-compose.sh
build`, in which case the image will be rebuilt from the `Dockerfile` in
the `app` directory instead of being pulled from the registry.

