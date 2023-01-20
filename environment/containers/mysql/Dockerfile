# syntax=docker/dockerfile:1.4

# Base image declaration
FROM mysql:8.0.32 AS base_image

# Development image declaration
FROM base_image as development
ENV MYSQL_DATABASE="laravel-app-db" \
    MYSQL_ROOT_PASSWORD="i_am_root"
COPY --link ./config.conf /etc/mysql/conf.d/mysql.cnf
RUN chmod 644 /etc/mysql/conf.d/mysql.cnf
