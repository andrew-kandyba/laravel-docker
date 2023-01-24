# syntax=docker/dockerfile:1.4

# Base image declaration
FROM nginx:1.23.3-alpine-slim as base_image
WORKDIR /app
RUN mkdir -p /var/run/php

# Development image declaration
FROM base_image as development
COPY --link config.conf /etc/nginx/conf.d/default.conf
RUN chmod 644 /etc/nginx/conf.d/default.conf
