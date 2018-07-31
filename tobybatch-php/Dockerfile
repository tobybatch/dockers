FROM php:7.1.20-fpm-alpine3.7
# TAG: tobybatch/php
LABEL maintainer tobias@neontribe.co.uk

RUN wget -O /tmp/composer-setup.php https://getcomposer.org/installer \
    && php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer \
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
        mysql-client \
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
    && rm /tmp/composer-setup.php

RUN apk --no-cache --virtual add acl

ENV PATH=${PATH}:/root/.composer/vendor/bin/
