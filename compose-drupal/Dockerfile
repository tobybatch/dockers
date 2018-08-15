FROM tobybatch/drupal
LABEL maintainer tobias@neontribe.co.uk

ARG DRUID=${DRUID}
ARG DRGID=${DRGID}
# drush can't use busy box a env
# RUN apk --no-cache --virtual add coreutils

WORKDIR /code
COPY includes/startup.sh /usr/local/bin/startup.sh

RUN sed -i "s/1000:1000/${DRUID}:${DRGID}/g" /etc/passwd
RUN sed -i "s/1000/${DRGID}/g" /etc/group

CMD /usr/local/bin/startup.sh
