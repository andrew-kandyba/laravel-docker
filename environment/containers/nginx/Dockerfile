# syntax=docker/dockerfile:1.4

# FROM nginx:1.23.3-alpine-slim as base_image
FROM nginx as base_image
      WORKDIR /app

FROM base_image as development
COPY --link config.conf /etc/nginx/conf.d/default.conf
RUN chmod 644 /etc/nginx/conf.d/default.conf
