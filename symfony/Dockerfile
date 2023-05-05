ARG PHP_VER="8.1"
ARG TIMEZONE="Europe/London"
ARG COMPOSER_VER="latest"
ARG BASE=fpm
ARG TYPE=prod

FROM php:${PHP_VER}-fpm-alpine AS fpm-php-ext-base
ARG BASE
ARG TYPE
RUN apk add --no-cache \
    # build-tools
    autoconf \
    dpkg \
    dpkg-dev \
    file \
    g++ \
    gcc \
    icu-dev \
    libatomic \
    libc-dev \
    libgomp \
    libmagic \
    linux-headers \
    m4 \
    make \
    mpc1 \
    mpfr4 \
    musl-dev \
    perl \
    re2c \
    # gd
    freetype-dev \
    libpng-dev \
    # icu
    icu-dev \
    # ldap
    openldap-dev \
    libldap \
    # zip
    libzip-dev \
    # xsl
    libxslt-dev \
    # pgsql
    libpq-dev

# apache debian php extension base
FROM php:${PHP_VER}-apache-buster AS apache-php-ext-base
ARG BASE
ARG TYPE
RUN apt-get update
RUN apt-get install -y \
        libldap2-dev \
        libicu-dev \
        libpng-dev \
        libzip-dev \
        libxslt1-dev \
        libfreetype6-dev \
        libpq-dev


# php extension gd - 13.86s
FROM ${BASE}-php-ext-base AS php-ext-gd
RUN docker-php-ext-configure gd \
        --with-freetype && \
    docker-php-ext-install -j$(nproc) gd

# php extension intl : 15.26s
FROM ${BASE}-php-ext-base AS php-ext-intl
RUN docker-php-ext-install -j$(nproc) intl

# php extension ldap : 8.45s
FROM ${BASE}-php-ext-base AS php-ext-ldap
RUN docker-php-ext-configure ldap && \
    docker-php-ext-install -j$(nproc) ldap

# php extension pdo_mysql : 6.14s
FROM ${BASE}-php-ext-base AS php-ext-pdo_mysql
RUN docker-php-ext-install -j$(nproc) pdo_mysql

FROM ${BASE}-php-ext-base AS php-ext-pdo_pgsql
RUN docker-php-ext-install -j$(nproc) pdo pdo_pgsql

# php extension zip : 8.18s
FROM ${BASE}-php-ext-base AS php-ext-zip
RUN docker-php-ext-install -j$(nproc) zip

# php extension xsl : ?.?? s
FROM ${BASE}-php-ext-base AS php-ext-xsl
RUN docker-php-ext-install -j$(nproc) xsl

# php extension redis
FROM ${BASE}-php-ext-base AS php-ext-redis
RUN yes no | pecl install redis && \
    docker-php-ext-enable redis

# php extension opcache
FROM ${BASE}-php-ext-base AS php-ext-opcache
RUN docker-php-ext-install -j$(nproc) opcache

FROM ${BASE}-php-ext-base AS php-ext-xdebug
RUN pecl install xdebug && docker-php-ext-enable xdebug

###########################
# fpm base build
###########################

# fpm base build
FROM php:${PHP_VER}-fpm-alpine AS fpm-base-prod
ARG TIMEZONE
ARG BASE
ARG TYPE
RUN apk add --no-cache \
        bash \
        coreutils \
        freetype \
        git \
        haveged \
        icu \
        libldap \
        libpng \
        libpq \
        libzip \
        libxslt-dev \
        fcgi \
        tzdata && \
    touch /use_fpm
EXPOSE 9000
HEALTHCHECK --interval=20s --timeout=10s --retries=3 \
    CMD \
    SCRIPT_NAME=/ping \
    SCRIPT_FILENAME=/ping \
    REQUEST_METHOD=GET \
    cgi-fcgi -bind -connect 127.0.0.1:9000 || exit 1

FROM fpm-base-prod AS fpm-base-dev
COPY --from=php-ext-xdebug /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
COPY --from=php-ext-xdebug /usr/local/lib/php/extensions/no-debug-non-zts-20210902/xdebug.so /usr/local/lib/php/extensions/no-debug-non-zts-20210902/xdebug.so

###########################
# apache base build
###########################

FROM php:${PHP_VER}-apache-buster AS apache-base-prod
ARG TIMEZONE
ARG BASE
ARG TYPE
COPY assets/000-default.conf /etc/apache2/sites-available/000-default.conf
RUN apt-get update && \
    apt-get install -y \
        bash \
        git \
        haveged \
        libicu63 \
        libpng16-16 \
        libzip4 \
        libpq5 \
        libxslt1.1 \
        libfreetype6 && \
    echo "Listen 8000" > /etc/apache2/ports.conf && \
    a2enmod rewrite && \
    touch /use_apache && \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/
EXPOSE 8000
HEALTHCHECK --interval=20s --timeout=10s --retries=3 \
    CMD curl -f http://127.0.0.1:8000 || exit 1

FROM  apache-base-prod AS apache-base-dev
COPY --from=php-ext-xdebug /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
COPY --from=php-ext-xdebug /usr/local/lib/php/extensions/no-debug-non-zts-20210902/xdebug.so /usr/local/lib/php/extensions/no-debug-non-zts-20210902/xdebug.so
EXPOSE 8000
HEALTHCHECK --interval=20s --timeout=10s --retries=3 \
    CMD curl -f http://127.0.0.1:8000 || exit 1


# global base build
FROM ${BASE}-base-${TYPE} AS base
ARG BASE
ARG TYPE
WORKDIR /opt/app
RUN ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && echo ${TIMEZONE} > /etc/timezone && \
    # make composer home dir
    mkdir /composer  && \
    chown -R www-data:www-data /composer

ENV TIMEZONE=${TIMEZONE}
ENV APP_ENV prod
ENV APP_SECRET=""
ENV DATABASE_URL=""
ENV CORS_ALLOW_ORIGIN=""
ENV MAILER_DSN=""

# copy composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

# copy php extensions

# PHP extension xsl
COPY --from=php-ext-xsl /usr/local/etc/php/conf.d/docker-php-ext-xsl.ini /usr/local/etc/php/conf.d/docker-php-ext-xsl.ini
COPY --from=php-ext-xsl /usr/local/lib/php/extensions/no-debug-non-zts-20210902/xsl.so /usr/local/lib/php/extensions/no-debug-non-zts-20210902/xsl.so
# PHP extension pdo_mysql
COPY --from=php-ext-pdo_mysql /usr/local/etc/php/conf.d/docker-php-ext-pdo_mysql.ini /usr/local/etc/php/conf.d/docker-php-ext-pdo_mysql.ini
COPY --from=php-ext-pdo_mysql /usr/local/lib/php/extensions/no-debug-non-zts-20210902/pdo_mysql.so /usr/local/lib/php/extensions/no-debug-non-zts-20210902/pdo_mysql.so
# PHP extension pdo_pgsql
COPY --from=php-ext-pdo_pgsql /usr/local/etc/php/conf.d/docker-php-ext-pdo_pgsql.ini /usr/local/etc/php/conf.d/docker-php-ext-pdo_pgsql.ini
COPY --from=php-ext-pdo_pgsql /usr/local/lib/php/extensions/no-debug-non-zts-20210902/pdo_pgsql.so /usr/local/lib/php/extensions/no-debug-non-zts-20210902/pdo_pgsql.so
# PHP extension zip
COPY --from=php-ext-zip /usr/local/etc/php/conf.d/docker-php-ext-zip.ini /usr/local/etc/php/conf.d/docker-php-ext-zip.ini
COPY --from=php-ext-zip /usr/local/lib/php/extensions/no-debug-non-zts-20210902/zip.so /usr/local/lib/php/extensions/no-debug-non-zts-20210902/zip.so
# PHP extension ldap
COPY --from=php-ext-ldap /usr/local/etc/php/conf.d/docker-php-ext-ldap.ini /usr/local/etc/php/conf.d/docker-php-ext-ldap.ini
COPY --from=php-ext-ldap /usr/local/lib/php/extensions/no-debug-non-zts-20210902/ldap.so /usr/local/lib/php/extensions/no-debug-non-zts-20210902/ldap.so
# PHP extension gd
COPY --from=php-ext-gd /usr/local/etc/php/conf.d/docker-php-ext-gd.ini /usr/local/etc/php/conf.d/docker-php-ext-gd.ini
COPY --from=php-ext-gd /usr/local/lib/php/extensions/no-debug-non-zts-20210902/gd.so /usr/local/lib/php/extensions/no-debug-non-zts-20210902/gd.so
# PHP extension intl
COPY --from=php-ext-intl /usr/local/etc/php/conf.d/docker-php-ext-intl.ini /usr/local/etc/php/conf.d/docker-php-ext-intl.ini
COPY --from=php-ext-intl /usr/local/lib/php/extensions/no-debug-non-zts-20210902/intl.so /usr/local/lib/php/extensions/no-debug-non-zts-20210902/intl.so
# PHP extension redis
COPY --from=php-ext-redis /usr/local/etc/php/conf.d/docker-php-ext-redis.ini /usr/local/etc/php/conf.d/docker-php-ext-redis.ini
COPY --from=php-ext-redis /usr/local/lib/php/extensions/no-debug-non-zts-20210902/redis.so /usr/local/lib/php/extensions/no-debug-non-zts-20210902/redis.so
COPY --from=php-ext-opcache /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini  /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini

COPY assets/dbtest.php /dbtest.php
