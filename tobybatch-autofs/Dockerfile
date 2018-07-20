FROM ubuntu:artful
LABEL maintainer tobias@neontribe.co.uk

ENV BROWSE_MODE="no"
# RUN apk add --no-cache --virtual autofs bash
RUN apt update && apt install -y autofs && rm -rf /var/lib/apt/lists/* && sed -i 's/#\/net/\/net/g' /etc/auto.master

CMD ["/usr/sbin/automount", "-t", "0", "-f", "/etc/auto.master"]
# docker build -t tobybatch/autofs --squash --rm .
