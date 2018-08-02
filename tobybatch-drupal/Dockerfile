FROM tobybatch/php
LABEL maintainer tobias@neontribe.co.uk

ENV UID=10001
ENV GID=50

RUN mkdir -p /home/drupal && \
    echo "drupal:x:1000:1000:drupal,,,:/home/drupal:/bin/bash" >> /etc/passwd && \
    echo "drupal:x:1000:" >> /etc/group && \
    echo "drupal ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/drupal && \
    chmod 0440 /etc/sudoers.d/drupal && \
    chown -R 1000:1000 /home/drupal

RUN rm -rf /root/.composer
USER drupal

RUN composer global require drush/drush:8
ENV PATH=/home/drupal/.composer/vendor/bin/:${PATH}

USER root

