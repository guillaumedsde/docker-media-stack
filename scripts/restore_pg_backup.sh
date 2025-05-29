#!/bin/bash

set -e
set -u
set -o pipefail
set -x

DB_SERVICE_NAME="${DB_SERVICE_NAME:-"${SERVICE_NAME}-db"}"
DOCKER_DATA_DIR="${DOCKER_DATA_DIR}"
DOCKER_USER="${DOCKER_USER}"

docker compose up --wait --pull always "${DB_SERVICE_NAME}"
docker compose exec --no-TTY "${DB_SERVICE_NAME}" /bin/sh -c 'psql --host localhost --user "${POSTGRES_USER}"' < "${SERVICE_NAME}_$(date --iso-8601).out"
