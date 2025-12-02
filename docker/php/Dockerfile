FROM php:8.4-fpm-alpine AS base
ARG extensions="pdo_sqlite pcntl zip"
COPY --from=composer:2.9.2 /usr/bin/composer /usr/bin/composer
COPY --from=mlocati/php-extension-installer --link /usr/bin/install-php-extensions /usr/local/bin/

RUN install-php-extensions $extensions \
    && rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

FROM base AS development
ARG extensions="xdebug xhprof"
COPY --link ./php.ini ${PHP_INI_DIR}/
COPY --link ./www.conf /usr/local/etc/php-fpm.d/www.conf

WORKDIR /var/www

RUN apk add --no-cache fcgi \
    && install-php-extensions $extensions \
    && rm -rf /var/cache/apk/* /tmp/* /var/tmp/* \
    && chown -R www-data:www-data /var/www

USER www-data
EXPOSE 9000

HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
    CMD SCRIPT_NAME=/ping \
        SCRIPT_FILENAME=/ping \
        REQUEST_METHOD=GET \
        cgi-fcgi -bind -connect php:9000 || exit 1

CMD ["php-fpm"]
