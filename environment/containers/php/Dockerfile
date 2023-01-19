# syntax=docker/dockerfile:1.4

# Base image declaration
FROM php:8.2.1-fpm-alpine3.17 as base_image
ENV LC_ALL=POSIX
COPY --from=mlocati/php-extension-installer --link /usr/bin/install-php-extensions /usr/local/bin/
RUN apk add --no-cache supervisor && \
    set -eux; install-php-extensions intl zip apcu opcache pcntl bcmath pdo_mysql
COPY --from=composer/composer:2.5.1-bin --link /composer /usr/bin/composer
WORKDIR app

# Development image declaration
FROM base_image as development
ENV PHP_IDE_CONFIG="serverName=127.0.0.1"
RUN set -eux; install-php-extensions xdebug
COPY --link ./config/php.ini $PHP_INI_DIR/
COPY --link ./config/supervisor.conf /etc/supervisor/
COPY --link ./config/worker.conf /etc/supervisor/conf.d/
COPY --link ./entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint
USER www-data
CMD ["php-fpm"]
ENTRYPOINT ["docker-entrypoint"]
