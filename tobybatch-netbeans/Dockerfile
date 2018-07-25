FROM ubuntu:18.04
LABEL maintainer Toby Batch "tobias@neontirbe.co.uk"

ENV UID=10001
ENV GID=50

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list && \
    apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer libxext-dev libxrender-dev libxtst-dev sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

ADD state.xml /tmp/state.xml

RUN wget http://download.netbeans.org/netbeans/8.2/final/bundles/netbeans-8.2-php-linux-x64.sh -O /tmp/netbeans.sh -q && \
    chmod +x /tmp/netbeans.sh && \
    echo 'Installing netbeans' && \
    /tmp/netbeans.sh --silent --state /tmp/state.xml && \
    rm -rf /tmp/*

RUN mkdir -p /home/developer && \
    echo "developer:x:${UID}:${GID}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${GID}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown developer:developer -R /home/developer

ADD startup.sh /usr/local/bin/startup.sh
CMD /usr/local/bin/startup.sh
