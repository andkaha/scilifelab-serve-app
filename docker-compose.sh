#!/bin/sh -

#-----------------------------------------------------------------------
# Shell script wrapper to simulate a "SciLifeLab Serve" application.
#
# To configure: Edit the "scilifelab-app.env" file.
#
# Neither this "docker-compose.sh" shell script nor the
# "scilifelab-compose.yml" Compose YAML file are supposed to be edited.
#
# Example usage (it simply replaces "docker compose"):
#
# 	./docker-compose.sh up -d
# 	./docker-compose.sh down
# 	./docker-compose.sh logs
#
#-----------------------------------------------------------------------

# Exit if trying to use undefined variables.
set -u

# Automatically promote all new variables to environment variables.
set -a

# Source the application settings (or exit if this failed).
. ./scilifelab-app.env || exit

# Don't create more envirenment variables automatically.
set +a

# Run the "docker compose" command that the user wanted.
exec docker compose -f scilifelab-compose.yml "$@"
