## Build

    docker build --rm tobybatch/httrack .

## Run 

    docker run \
        -ti --rm \
        -p 8081:80 \
        -v $(pwd)/site:/usr/share/nginx/html \
        --name httrack \
        -e REMOTE_HOST="http://192.168.51.200" \
        tobybatch/httrack
