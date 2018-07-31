FROM jenkins/jenkins:lts
MAINTAINER tobias@neontribe.co.uk

ENV DEAMONJSON='{"insecure-registries": ["192.168.21.237:5000", "neonkvm:5000"]}'

USER root

RUN mkdir /etc/docker
RUN echo $DEAMONJSON > /etc/docker/daemon.json

RUN apt update && apt -y install apt-transport-https dirmngr
RUN echo 'deb https://apt.dockerproject.org/repo debian-stretch main' >> /etc/apt/sources.list
RUN apt-key adv \
  --keyserver hkp://p80.pool.sks-keyservers.net:80 \
  --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN apt-get update && apt install -y docker-engine
RUN usermod -a -G docker jenkins

USER jenkins

# ENTRYPOINT ["/bin/bash"] 

