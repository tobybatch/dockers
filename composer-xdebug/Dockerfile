FROM webdevops/php-apache

MAINTAINER Oliver Barnwell

RUN apt-get update && \
  apt-get install php-xdebug

COPY xdebug.ini /etc/php/7.0/mods-available/xdebug.ini

COPY start.sh /usr/local/bin/start.sh
RUN chmod +x usr/local/bin/start.sh

EXPOSE 8080
CMD ["start.sh"]
