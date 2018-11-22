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

    docker exec calibre calibredb add /to-add/pg1013.epub --with-library http://localhost:8080
