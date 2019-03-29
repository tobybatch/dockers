FROM tobybatch/php
LABEL maintainer tobias@neontribe.co.uk

WORKDIR /opt
ARG ACCOUNT_NAME=superadmin
ARG ACCOUNT_PASS=changeme
ARG ACCOUNT_MAIL=drupal@example.com

RUN mkdir -p /home/drupal && \
    echo "drupal:x:1000:1000:drupal,,,:/home/drupal:/bin/bash" >> /etc/passwd && \
    echo "drupal:x:1000:" >> /etc/group && \
    echo "drupal ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/drupal && \
    chmod 0440 /etc/sudoers.d/drupal && \
    chown -R 1000:1000 /home/drupal && \
    rm -rf /root/.composer && \
    chown -R drupal:drupal /opt && \
    apk --no-cache add git sudo && \
    composer global require drush/drush:8 && \
    composer create-project drupal-composer/drupal-project:8.x-dev /opt/drupal --stability dev --no-interaction

# This is in a seperate layer as it re-builds if the ARGS change
RUN drush site-install -y --root=/opt/drupal --db-url=sqlite://sites/default/files/.ht.sqlite --account-name=${ACCOUNT_NAME} --account-pass=${ACCOUNT_PASS} --account-mail=${ACCOUNT_MAIL} && \
    chown -R drupal:drupal /opt/drupal

# ENV UID=10001
# ENV GID=50
ENV PATH=/home/drupal/.composer/vendor/bin/:${PATH}
WORKDIR /opt/drupal/web

USER drupal
RUN composer global require drush/drush:8

CMD sudo chown -R drupal:drupal /opt/drupal/web/sites/default && drush rs 0.0.0.0:8888
