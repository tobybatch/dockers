FROM tobybatch/php
# TAG: tobybatch/php
LABEL maintainer tobias@neontribe.co.uk

# Drush 8 works with both drupal 7 & 8
RUN composer global require drush/drush:8

WORKDIR /code
COPY startup.sh /usr/local/bin/startup.sh
CMD /usr/local/bin/startup.sh
