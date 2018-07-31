# Jenkins with Docker

Git hub here: https://github.com/tobybatch/jenkins-with-docker

    docker build \
        --rm \
        -t tobybatch/jenkins-with-docker \
        -e DEAMONJSON='{"insecure-registries": ["192.168.21.237:5000", "neonkvm:5000"]}' \
        .

    docker run \
        --name haven-jenkins \
        -p 8080:8080 \
        -p 50000:50000 \
        -v jenkins_home:/var/jenkins_home \
        -v /var/run/docker.sock:/var/run/docker.sock \
        tobybatch/jenkins-with-docker
