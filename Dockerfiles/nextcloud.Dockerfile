FROM nextcloud:21-apache

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt install -y procps smbclient libsmbclient-dev \
    && pecl install smbclient \
    && docker-php-ext-enable smbclient \
    && echo "extension=smbclient.so" > /usr/local/etc/php/conf.d/docker-php-ext-smbclient.ini \
    && rm -rf /var/lib/apt/lists/*