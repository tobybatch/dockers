= Motion docker =

## Quick start

Start the docker attached to a video device:

    docker run -td -v /dev/video0:/dev/video0 tobybatch/docker-motion
    docker run -td -v /dev/video1:/dev/video0 tobybatch/docker-motion

Start the docker to listen to network camera:

    docker run -td -e "netcam_url=http://192.168.51.26/videostream.cgi?user=motion&pwd=motion"

## File system

### Config folder

Mount a config folder:

    docker run -td -v config:/data/conf tobybatch/docker-motion

In the config folder you can place a mask file and/or a thread override config, e.g

    conf/
    ├── mask.pgm
    └── thread1.conf

### Media folder

    docker run -td -v media:/data/media

### G-Drive

You need to mount the auth token into th docker at run time and then tell the docker where to upload the file to:

    docker run -td -v ~/.gdrive:/data/gdrive -e GDRIVE_DIR=THE_ID_OF_MY_GDRIVE_FOLER tobybatch/docker-motion

## Full Examples

Using video device:

    docker run -td --privileged -v /dev/video0:/dev/video0 -v config:/data/conf -v media:/data/media -v ~/.gdrive:/data/gdrive -e GDRIVE_DIR=THE_ID_OF_MY_GDRIVE_FOLER -p 8585:8081 tobybatch/docker-motion

Using net cam:

    docker run -td -e "netcam_url=http://192.168.51.26/videostream.cgi?user=motion&pwd=motion" -v config:/data/conf -v media:/data/media -v ~/.gdrive:/data/gdrive -p 8585:8081 tobybatch/docker-motion
