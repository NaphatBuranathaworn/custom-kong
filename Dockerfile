FROM kong:2.4.1-alpine

### Set timezone
ENV TZ=Asia/Bangkok

### Declare env plugins need
# ENV KONG_NGINX_MAIN_ENV=""

### Register custom plugin
ENV KONG_PLUGINS=bundled,lua-custom-key

### Log level
ENV KONG_LOG_LEVEL=info

USER root

### Install Deck Kong config Import/Export 
RUN apk add --update curl
RUN curl -sL https://github.com/kong/deck/releases/download/v1.2.0/deck_1.2.0_linux_amd64.tar.gz -o deck.tar.gz
RUN tar -xf deck.tar.gz -C /tmp
RUN cp /tmp/deck /usr/local/bin/

### Install lua cryptographic library
RUN echo "" > /etc/apk/repositories
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.11/main' >> /etc/apk/repositories
RUN apk add cmake
RUN apk add clang clang-dev make gcc g++ libc-dev linux-headers
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.14/main' >> /etc/apk/repositories
RUN apk add nettle>3.7.3-r0.apk

### Install for luasodium
RUN apk update && apk add --update gcc g++ libsodium-dev

COPY lua-plugins/ /usr/local/kong/lua-plugins/
RUN cd /usr/local/kong/lua-plugins/ && luarocks make

RUN chown -R nobody:nobody /usr/local/kong