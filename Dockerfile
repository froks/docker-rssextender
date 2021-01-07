FROM alpine:3.12.3

ENV S6_VERSION=v2.1.0.2

LABEL description="Self-hosted RSS-Extender environment." \
      maintainer="Florian Roks <flo.githubdocker@debugco.de>"

RUN set -xe && \
    apk update && apk upgrade && \
    apk add --no-cache --virtual=run-deps \
    busybox nginx git ca-certificates curl \
    php7 php7-curl php7-dom php7-fpm

# Add user www-data for php-fpm.
# 82 is the standard uid/gid for "www-data" in Alpine.
RUN adduser -u 82 -D -S -G www-data www-data

# Copy root file system.
COPY root /

# Add s6 overlay.
# Note: Tweak this line if you're running anything other than x86 AMD64 (64-bit).
RUN curl -L -s https://github.com/just-containers/s6-overlay/releases/download/$S6_VERSION/s6-overlay-amd64.tar.gz | tar xvzf - -C /

# Expose Nginx port.
EXPOSE 8080

# Clean up.
RUN set -xe && apk del --progress --purge && rm -rf /var/cache/apk/* && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/init"]
