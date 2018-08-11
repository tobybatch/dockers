FROM nginx

ENV REMOTE_HOST=http://localhost
ENV FILTER=

RUN apt update && apt install -y httrack && rm -rf /var/lib/apt/lists/*
RUN rm -rf /usr/share/nginx/html/*
RUN touch /usr/share/nginx/html/hts-log.txt
COPY startup.sh /startup.sh
CMD /startup.sh
EXPOSE 80
