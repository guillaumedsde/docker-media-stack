#!/bin/bash

docker_images=$(docker_data_folder=/data data_folder=/data docker compose config --images 2>/dev/null)

while IFS= read -r docker_image; do
    trivy image \
        --disable-telemetry \
        --skip-version-check \
        --parallel=0 \
        --severity=CRITICAL,HIGH \
        --ignore-unfixed \
        "${docker_image}"
done <<< "$docker_images"
