FROM nextcloud:latest

RUN apt-get update \
    && apt-get install -y \
    procps \
    smbclient \
    libsmbclient-dev \
    libmagickcore-6.q16-3-extra \
    && pecl install smbclient \
    && docker-php-ext-enable smbclient \
    && rm -rf /var/lib/apt/lists/*