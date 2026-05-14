#!/bin/sh
set -eu

vpn_interface="${1}"
port_number="${2}"

# Set the Qbittorrent port number
wget "http://localhost:8080/api/v2/app/setPreferences" \
    --output-document - \
    --no-verbose \
    --retry-connrefused \
    --post-data \
    "json={\"listen_port\":${port_number},\"current_network_interface\":\"${vpn_interface}\",\"random_port\":false,\"upnp\":false}"
