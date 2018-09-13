# =========================================
FROM php:7.2.9-apache-stretch AS composer
MAINTAINER Toby Batch <tobias@neontribe.co.uk>
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

# =========================================
FROM composer as syphp
MAINTAINER Toby Batch <tobias@neontribe.co.uk>
RUN apt update \
    && apt install -y \
       bash \
       ccze \
       git \
       libicu-dev \
       libldb-dev \
       libldap2-dev \
       patch \
       unzip \
       vim \
       wget \
       zip \
    && docker-php-ext-install intl \
    && docker-php-ext-configure intl \
    && docker-php-ext-install ldap  \
    && docker-php-ext-configure ldap \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-configure pdo_mysql \
    && rm -rf /var/lib/apt/lists/*

# =========================================
FROM syphp as kimai
MAINTAINER Toby Batch <tobias@neontribe.co.uk>
WORKDIR /opt/
RUN wget -O /opt/kimai.zip https://codeload.github.com/kevinpapst/kimai2/legacy.zip/master \
    && unzip kimai.zip \
    && mv kevin* kimai \
    && rm kimai.zip 

WORKDIR /opt/kimai
RUN composer require symfony/requirements-checker \
    && composer remove symfony/requirements-checker \
    && sed -i "s#/var/www/html#/opt/kimai/public#g" /etc/apache2/sites-enabled/000-default.conf \
    && sed -i "/<\/Virt/i <Directory /opt/kimai/public>\n  Require all granted\n</Directory>" /etc/apache2/sites-enabled/000-default.conf

ENV APP_ENV=prod
ENV DATABASE_URL=$DATABASE_URL
ENV DATABASE_PREFIX=k_

ENV ADMIN_USER=superadmin
ENV ADMIN_PASS=changeme
ENV ADMIN_MAIL=admin@example.com

COPY dbtest.php /usr/local/bin/dbtest.php
COPY startup.sh /usr/local/bin/startup.sh

CMD /usr/local/bin/startup.sh
# CMD apachectl -D FOREGROUND
# ENTRYPOINT [ "/bin/sleep", "10000" ]
