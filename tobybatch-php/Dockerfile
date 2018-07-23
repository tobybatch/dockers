FROM php:7.2.7-fpm-alpine3.7
# TAG: tobybatch/php
LABEL maintainer tobias@neontribe.co.uk

# RUN apt update && apt install -y wget
RUN wget -O /tmp/composer-setup.php https://getcomposer.org/installer \
    && php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    # && apt install -y libpng-dev icu-devtools gettext bash unzip git libcurl3 \
    && apk --no-cache --virtual add \
        bash \
        curl-dev \
        freetype-dev \
        gettext-dev \
        icu-dev \
        libxml2-dev \
        libpng-dev \
        libpng-dev \
        libjpeg-turbo-dev \
        mysql \
        openldap-dev \
        sqlite \
        sqlite-dev \
    && docker-php-ext-install \
        ctype \
        curl \
        dom \
        gd \
        gettext \
        iconv \
        intl \
        json \
        ldap \
        mbstring \
        pdo \
        pdo_mysql \
        pdo_sqlite \
        phar \
        posix \
        session \
        soap \
        tokenizer \
        xml \
        xmlrpc \
        xmlwriter \
        zip \
    && docker-php-ext-enable \
        ctype \
        curl \
        dom \
        gd \
        gettext \
        iconv \
        intl \
        json \
        ldap \
        mbstring \
        pdo \
        pdo_mysql \
        pdo_sqlite \
        phar \
        posix \
        session \
        soap \
        tokenizer \
        xml \
        xmlrpc \
        xmlwriter \
        zip \
    && rm /tmp/composer-setup.php \
    && rm -rf /var/lib/apt/lists/* \
    && echo "[global]" > /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "daemonize = no" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "[www]" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "listen = 9000" >> /usr/local/etc/php-fpm.d/zz-docker.conf

ENV PATH=${PATH}:/root/.composer/vendor/bin/
