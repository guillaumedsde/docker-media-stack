FROM nextcloud:21-apache

RUN apt-get update; \
    apt-get install -y --no-install-recommends \
    ffmpeg \
    libmagickcore-6.q16-6-extra \
    procps \
    smbclient \
    ; \
    rm -rf /var/lib/apt/lists/*; \
    savedAptMark="$(apt-mark showmanual)"; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    libbz2-dev \
    libc-client-dev \
    libkrb5-dev \
    libsmbclient-dev \
    ; \
    docker-php-ext-install \
    bz2 \
    ; \
    pecl install smbclient; \
    docker-php-ext-enable smbclient; \
    # reset apt-mark's "manual" list so that "purge --auto-remove" will remove all build dependencies
    apt-mark auto '.*' > /dev/null; \
    apt-mark manual $savedAptMark; \
    ldd "$(php -r 'echo ini_get("extension_dir");')"/*.so \
    | awk '/=>/ { print $3 }' \
    | sort -u \
    | xargs -r dpkg-query -S \
    | cut -d: -f1 \
    | sort -u \
    | xargs -rt apt-mark manual; \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
    rm -rf /var/lib/apt/lists/*