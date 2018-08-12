FROM nginx

ENV REMOTE_HOST=http://localhost
ENV FILTER=

RUN apt update && apt install -y httrack && rm -rf /var/lib/apt/lists/* \
    && rm -rf /usr/share/nginx/html/* \
    && touch /usr/share/nginx/html/hts-log.txt \
    && rm -rf /var/lib/apt/lists/*

COPY startup.sh /startup.sh
CMD /startup.sh
EXPOSE 80
