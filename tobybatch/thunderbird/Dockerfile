FROM ubuntu:18.04
# FROM ubuntu:18.04
LABEL maintainer Toby Batch "tobias@neontribe.co.uk"

ENV UID=10001
ENV GID=50

RUN apt-get update && apt-get install -y thunderbird sudo
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*
 
RUN mkdir -p /home/thunderbird && \
    echo "thunderbird:x:${UID}:${GID}:thunderbird,,,:/home/thunderbird:/bin/bash" >> /etc/passwd && \
    echo "thunderbird:x:${GID}:" >> /etc/group && \
    echo "thunderbird ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/thunderbird && \
    chmod 0440 /etc/sudoers.d/thunderbird && \
    chown thunderbird:thunderbird -R /home/thunderbird

ADD startup.sh /usr/local/bin/startup.sh
CMD /usr/local/bin/startup.sh
