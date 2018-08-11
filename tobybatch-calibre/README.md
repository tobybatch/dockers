# Calibre Server

## Build

    docker build -t tobybatch/calibre --rm .

## Run

    docker run --name calibre -d -p 8080:8080 \
        -v $(pwd)/to-add:/to-add \
        -v calibre-library:/library \
        tobybatch/calibre

## Add books

Just copy the books into the to add local folder and restart the docker.
