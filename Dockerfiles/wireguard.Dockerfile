FROM ghcr.io/linuxserver/wireguard:latest

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ufw \
    && rm -rf /var/lib/apt/lists/*