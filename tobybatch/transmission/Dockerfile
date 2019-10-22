FROM ubuntu

# ENV REMOTE_HOST=http://localhost
# ENV FILTER=

RUN apt update && apt install -y transmission-daemon && mkdir /download
ADD startup.sh /startup.sh
ADD settings.json /etc/transmission-daemon/settings.json

EXPOSE 9091

ENV BLOCKLIST_URL http://john.bitsurge.net/public/biglist.p2p.gz
ENV RPC_USERNAME transmission
ENV RPC_PASSWORD transmission

ENTRYPOINT /bin/bash
