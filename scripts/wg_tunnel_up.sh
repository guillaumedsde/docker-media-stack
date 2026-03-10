#!/bin/sh
set -eu

vpn_interface="${1}"
port_number="${2}"

# Set the Qbittorrent prot number
wget "http://localhost:8080/api/v2/app/setPreferences" \
    --output-document - \
    --no-verbose \
    --retry-connrefused \
    --post-data \
    "json={\"listen_port\":${port_number},\"current_network_interface\":\"${vpn_interface}\",\"random_port\":false,\"upnp\":false}"

# Restart qbittorrent
wget "http://localhost:8080/api/v2/app/shutdown" \
    --method POST \
    --output-document - \
    --no-verbose \
    --retry-connrefused

PROWLARR_API_KEY=$(cat /run/secrets/PROWLARR_API_KEY)

# Restart Prowlarr
wget "http://localhost:9696/api/v1/system/restart" \
    --header "X-Api-Key: ${PROWLARR_API_KEY}"  \
    --method POST \
    --output-document - \
    --no-verbose \
    --retry-connrefused
