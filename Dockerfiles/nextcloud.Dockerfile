FROM nextcloud:latest

RUN apt-get update && apt-get install -y php-smbclient && rm -rf /var/lib/apt/lists/*