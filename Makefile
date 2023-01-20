.DEFAULT_GOAL := help
.PHONY: help

# Internal variables:
APP_DOMAIN := "math-solver.localhost"
DISABLE_XDEBUG := XDEBUG_MODE=off
ENABLE_DOCKER_BUILDKIT := DOCKER_BUILDKIT=1

IMAGE_LABEL := "development"
IMAGE_NGINX := "laravel-app/nginx"
IMAGE_NGINX_CONTEXT := "$(PWD)/environment/containers/nginx/."
IMAGE_PHP := "laravel-app/php"
IMAGE_PHP_CONTEXT := "$(PWD)/environment/containers/php/."

SSL_DIRECTORY := "$(PWD)/environment/ssl/"

# Available commands:
help:
	@grep -E '^[a-zA-Z-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "[32m%-27s[0m %s\n", $$1, $$2}'

build: ## Building application images.
	@$(ENABLE_DOCKER_BUILDKIT) docker build --tag $(IMAGE_NGINX):$(IMAGE_LABEL) \
                                                --target $(IMAGE_LABEL) $(IMAGE_NGINX_CONTEXT)
	@$(ENABLE_DOCKER_BUILDKIT) docker build --tag $(IMAGE_PHP):$(IMAGE_LABEL) \
						--target $(IMAGE_LABEL) $(IMAGE_PHP_CONTEXT)

start: ## Create and start application containers.
	@make .generate-ssl
	@docker-compose up -d

stop: ## Stop and remove containers and resources.
	@docker-compose down -v
	@make .clean-ssl

.generate-ssl:
	@mkdir -p $(SSL_DIRECTORY)
	@mkcert --install && \
	mkcert -cert-file $(SSL_DIRECTORY)/mkcert-cert.pem -key-file $(SSL_DIRECTORY)/mkcert-key.pem laravel-app.localhost

.clean-ssl:
	@rm -rf $(SSL_DIRECTORY)
