# docker-netbeans

NetBeans v8.2 in a Docker container

## Credit where credit is due

This is based pretty much totally based on https://github.com/fgrehm/docker-netbeans

## Quick start

```sh
docker run -d \
    --name netbeans \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME/.netbeans:/home/developer/.netbeans \
    -v $HOME/workspace:/home/developer/workspace \
    --memory 2048m \
    -e UID=$(id -u) \
    -e GID=$(id -g) \
    tobybatch/netbeans
```

### Quick start explained

 * ```docker run -d``` Start the docker in the background.
 * ```-e DISPLAY=$DISPLAY```  Tell X applications which X server to display on.
 * ```-v /tmp/.X11-unix:/tmp/.X11-unix```  Mount the host X socket in the docker.
 * ```-v $HOME/.netbeans:/root/.netbeans``` Use a docker volume called netbeans to store config and plugind between sessions.
 * ```-v $HOME/workspace:/home/developer/workspace```  Mount out user workspace inthe docker.
 * ```--memory 2048m```  Some netbeans using ALL your memeory and then grinding it bits off your SSD in the form of a swap file.
 * ```-e UID=$(id -u)```  Switch the UID of the docker user to match your user.
 * ```-e GID=$(id -g)``` Switch the GID of the docker user to match your user. 
 * ```tobybatch/netbeans``` Name of the docker.

## Build

    docker build -t tobybatch/netbeans . 

