# syntax=docker/dockerfile:1.4

# Base image declaration
FROM php:8.2.1-fpm-alpine3.17 as base_image
ENV LC_ALL=POSIX
WORKDIR /app
COPY --from=mlocati/php-extension-installer:1.5.52 --link /usr/bin/install-php-extensions /usr/local/bin/
COPY --from=composer/composer:2.5.1-bin --link /composer /usr/bin/composer
RUN apk add --no-cache supervisor && \
    set -eux; install-php-extensions intl zip apcu opcache pcntl bcmath pdo_mysql

# Development image declaration
FROM base_image as development
ARG DB \
    DB_PASS \
    DB_PORT \
    DOMAIN
ENV PHP_IDE_CONFIG="serverName=127.0.0.1" \
    DB=$DB \
    DB_PORT=$DB_PORT \
    DB_PASS=$DB_PASS \
    DOMAIN=$DOMAIN
COPY --link ./config/php.ini $PHP_INI_DIR/
COPY --link ./config/supervisor.conf /etc/supervisor/
COPY --link ./entrypoint.sh /usr/local/bin/docker-entrypoint
COPY --link ./config/zz-docker.conf /usr/local/etc/php-fpm.d/zz-docker.conf
RUN set -eux; install-php-extensions xdebug && \
    chmod +x /usr/local/bin/docker-entrypoint && \
    mkdir -p /var/run/php
CMD ["php-fpm"]
ENTRYPOINT ["docker-entrypoint"]
