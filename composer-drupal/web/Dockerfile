FROM nginx:latest
# TAG: tobybatch/php
LABEL maintainer tobias@neontribe.co.uk

ENV DR_PORT=8989

WORKDIR /code
ADD site.conf /etc/nginx/conf.d/default.conf
ADD startup.sh /usr/local/bin/startup.sh

CMD /usr/local/bin/startup.sh
