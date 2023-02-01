# syntax=docker/dockerfile:1.4

# Base image declaration
FROM nginx:1.23.3-alpine-slim as base_image
WORKDIR /app

# Development image declaration
FROM base_image as development
ARG GID
ENV GID=$GID
COPY --link config.conf /etc/nginx/conf.d/default.conf
RUN apk add --no-cache shadow && \
    mkdir -p /var/run/php && \
    groupmod -og $GID www-data && \
    chown nginx:www-data /var/run/php && \
    chmod 770 /var/run/php && \
    chmod 644 /etc/nginx/conf.d/default.conf
