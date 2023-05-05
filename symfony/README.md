# Symfony ready docker

PHP base docker that is symfony/laravel ready. Built as a matrix of apapche/fpm and dev/prod

It does not install an app, but builds the docker ready to be used in other dockers.

## Build

```
docker build -t tobybatch/php:8.1-fpm . && \
docker build -t tobybatch/php:8.1-fpm-dev --build-arg TYPE=dev . && \
docker build -t tobybatch/php:8.1-apache --build-arg BASE=apache . && \
docker build -t tobybatch/php:8.1-apache-dev --build-arg BASE=apache --build-arg TYPE=dev .
```

## Push

```
for x in fpm fpm-dev apache apache-dev; do docker push tobybatch/php:8.1-$x; done
```
