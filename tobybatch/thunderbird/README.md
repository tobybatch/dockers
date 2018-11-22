# docker-thunderbird

Thunderbird in a Docker container

## Quick start

```sh
docker run -d \
    --name thunderbird \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME/.thunderbird:/home/thunderbird/.thunderbird \
    --memory 1024m \
    -e UID=$(id -u) \
    -e GID=$(id -g) \
    tobybatch/thunderbird
```

### Quick start explained

 * ```docker run -d``` Start the docker in the background.
 * ```-e DISPLAY=$DISPLAY```  Tell X applications which X server to display on.
 * ```-v /tmp/.X11-unix:/tmp/.X11-unix```  Mount the host X socket in the docker.
 * ```-v $HOME/.thunderbird:/home/thunderbird/.thunderbird``` Use a docker volume called thunderbird to store config and plugind between sessions.
 * ```--memory 1024m```  Some thunderbird using ALL your memeory and then grinding it bits off your SSD in the form of a swap file.
 * ```-e UID=$(id -u)```  Switch the UID of the docker user to match your user.
 * ```-e GID=$(id -g)``` Switch the GID of the docker user to match your user. 
 * ```tobybatch/thunderbird``` Name of the docker.

## Build

    docker build -t tobybatch/thunderbird .
