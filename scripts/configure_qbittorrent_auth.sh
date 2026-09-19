#!/bin/sh

# Simple script to configure qbittorrent authentication bypass for traefik
# This script runs before qbittorrent starts and updates the configuration

set -eu

# Path to qbittorrent configuration file
CONFIG_FILE="/config/qBittorrent.conf"

# Create config directory if it doesn't exist
mkdir -p "/config"

# Create a basic config file if it doesn't exist
touch "$CONFIG_FILE"

# Try to get traefik's IP (best effort)
traefik_ip=""
if command -v getent >/dev/null 2>&1; then
    traefik_ip=$(getent hosts traefik | awk '{print $1}' | head -n 1 || true)
fi

# If we couldn't get traefik's IP, fall back to localhost
if [ -z "$traefik_ip" ]; then
    echo "Could not resolve traefik IP, falling back to localhost only"
    traefik_ip="127.0.0.1"
else
    echo "Configuring qbittorrent to bypass authentication for traefik IP: $traefik_ip"
fi

# Update the configuration file
# Remove existing settings to avoid duplicates
if grep -q "^AuthSubnetWhitelist=" "$CONFIG_FILE"; then
    sed -i "/^AuthSubnetWhitelist=/d" "$CONFIG_FILE"
fi
if grep -q "^AuthSubnetWhitelistEnabled=" "$CONFIG_FILE"; then
    sed -i "/^AuthSubnetWhitelistEnabled=/d" "$CONFIG_FILE"
fi

# Add the new settings
echo "AuthSubnetWhitelist=$traefik_ip" >> "$CONFIG_FILE"
echo "AuthSubnetWhitelistEnabled=true" >> "$CONFIG_FILE"

# Start qbittorrent with the original command
exec "$@"