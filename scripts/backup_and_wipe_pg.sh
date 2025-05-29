#!/bin/bash

set -e
set -u
set -o pipefail
set -x

DB_SERVICE_NAME="${DB_SERVICE_NAME:-"${SERVICE_NAME}-db"}"
DOCKER_DATA_DIR="${DOCKER_DATA_DIR}"
DOCKER_USER="${DOCKER_USER}"

docker compose stop "${SERVICE_NAME}"
docker compose exec "${DB_SERVICE_NAME}" /bin/sh -c 'pg_dumpall --host localhost --user "${POSTGRES_USER}"' > "${SERVICE_NAME}_$(date --iso-8601).out"
docker compose stop "${DB_SERVICE_NAME}"

sudo mv "${DOCKER_DATA_DIR}/${DB_SERVICE_NAME}" "${DOCKER_DATA_DIR}/${DB_SERVICE_NAME}.old"
sudo mkdir "${DOCKER_DATA_DIR}/${DB_SERVICE_NAME}"
sudo chmod 700 "${DOCKER_DATA_DIR}/${DB_SERVICE_NAME}"
sudo chown "${DOCKER_USER}": "${DOCKER_DATA_DIR}/${DB_SERVICE_NAME}"
