FROM ubuntu
LABEL maintainer tobias@neontribe.co.uk

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y calibre \
    && apt install -y curl \
    && mkdir /library /to-add \
    && curl -L https://www.gutenberg.org/ebooks/83.epub.noimages -o /to-add/From_the_Earth_to_the_Moon.epub \
    && echo "#!/bin/bash" > /startup.sh \
    && echo "if [ ! -f /library/metadata.db ]; then" >> /startup.sh \
    && echo "  curl -L https://www.gutenberg.org/ebooks/83.epub.noimages -o /to-add/From_the_Earth_to_the_Moon.epub" >> /startup.sh \
    && echo "fi" >> /startup.sh \
    && echo "calibredb add /to-add/* --with-library /library" >> /startup.sh \
    && echo "calibre-server /library --enable-local-write " >> /startup.sh \
    && chmod 777 /startup.sh

CMD /startup.sh

# docker build -t tobybatch/calibre --rm .
