# syntax=docker/dockerfile:1.4

# Base image declaration
FROM mysql:8.0.32 AS base_image

# Development image declaration
FROM base_image as development
ARG DATABASE \
    PORT \
    ROOT_PASSWORD
ENV MYSQL_DATABASE=$DATABASE \
    MYSQL_ROOT_PASSWORD=$ROOT_PASSWORD \
    MYSQL_TCP_PORT=$PORT
COPY --link ./config.conf /etc/mysql/conf.d/mysql.cnf
RUN chmod 644 /etc/mysql/conf.d/mysql.cnf
