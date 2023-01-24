include $(PWD)/docker.env
export

.DEFAULT_GOAL := help
.PHONY: help

# Internal variables:
ENABLE_DOCKER_BUILDKIT := DOCKER_BUILDKIT=1
ENV_FILE := --env-file $(PWD)/docker.env
SSL_DIRECTORY := "$(PWD)/environment/ssl"

# Available commands:
test:
	env
help:
	@grep -E '^[a-zA-Z-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "[32m%-27s[0m %s\n", $$1, $$2}'

build: ## Building application images.
	@$(ENABLE_DOCKER_BUILDKIT) docker build --tag $(PROJECT)/mysql:$(IMAGE_LABEL) \
						--build-arg DATABASE=$(MYSQL_DATABASE) \
						--build-arg PORT=$(MYSQL_PORT) \
						--build-arg ROOT_PASSWORD=$(MYSQL_ROOT_PASSWORD) \
						--target $(IMAGE_LABEL) $(IMAGE_CONTEXT)/mysql/.
	@$(ENABLE_DOCKER_BUILDKIT) docker build --tag $(PROJECT)/nginx:$(IMAGE_LABEL) \
                                                --target $(IMAGE_LABEL) $(IMAGE_CONTEXT)/nginx/.
	@$(ENABLE_DOCKER_BUILDKIT) docker build --tag $(PROJECT)/php:$(IMAGE_LABEL) \
						--build-arg DOMAIN=$(LOCALHOST_DOMAIN) \
						--build-arg DB=$(MYSQL_DATABASE) \
						--build-arg DB_PASS=$(MYSQL_ROOT_PASSWORD) \
						--build-arg DB_PORT=$(MYSQL_PORT) \
						--target $(IMAGE_LABEL) $(IMAGE_CONTEXT)/php/.

build-laravel: ## Building laravel-app skeleton.
	@rm -rf $(LARAVEL_DIRECTORY)
	@composer create-project --no-install --no-scripts laravel/laravel $(LARAVEL_DIRECTORY)
	@cp $(PWD)/laravel-env.example $(LARAVEL_DIRECTORY)/.env.example
	@cp $(LARAVEL_DIRECTORY)/.env.example $(LARAVEL_DIRECTORY)/.env

start: ## Create and start application containers.
	@make .generate-ssl
	@docker-compose $(ENV_FILE) up -d

stop: ## Stop and remove containers and resources.
	@docker-compose $(ENV_FILE) down -v
	@make .clean-ssl

shell: ## Get shell inside php container.
	@docker-compose exec php /bin/ash

.generate-ssl:
	@mkdir -p $(SSL_DIRECTORY)
	@mkcert --install && \
	mkcert -cert-file $(SSL_DIRECTORY)/mkcert-cert.pem -key-file $(SSL_DIRECTORY)/mkcert-key.pem $(LOCALHOST_DOMAIN)

.clean-ssl:
	@rm -rf $(SSL_DIRECTORY)
