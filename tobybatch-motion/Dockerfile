FROM ubuntu:artful
MAINTAINER tobias@neontribe.co.uk

RUN apt update
RUN apt install -y \
      motion \
      ffmpeg \
      v4l-utils \
      python-pip \
      python-dev \
      curl \
      libssl-dev \
      libcurl4-openssl-dev \
      libjpeg-dev

RUN apt install -y vim less ccze wget

# ENV netcam_url http://192.168.1.26/videostream.cgi?user=motion&pwd=motion
ENV netcam_url false
# ENV videodevice /dev/video0
# ENV mask_file false
# ENV webcontrol_authentication admin:motion
ENV GDRIVE_DIR=0

# ENV MOTION_CFG /core/config_core/motion.conf

RUN mkdir -p /data/media /data/conf /core/config_core /data/gdrive

COPY motion.conf /core/config_core/motion.conf
COPY README.md /core/config_core/README.md

COPY startup.sh /usr/local/bin/startup.sh
COPY gdrive-upload.sh /usr/local/bin/gdrive-upload.sh

# Now install gdrive
RUN wget -O gdrive "https://docs.google.com/uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA&export=download" && chmod +x gdrive && install gdrive /usr/local/bin/gdrive
ENV GDRIVE_CONFIG_DIR="/data/gdrive"

EXPOSE 8081
ENTRYPOINT ["/usr/local/bin/startup.sh"]
