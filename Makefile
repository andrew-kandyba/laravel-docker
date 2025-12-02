.DEFAULT_GOAL := help
.PHONY: help build install start stop restart shell test lint

INSTALL = 'composer create-project laravel/laravel . \
           && composer r --dev sentry/sentry-laravel \
           && composer r --dev inspector-apm/inspector-laravel \
           && composer r --dev maantje/xhprof-buggregator-laravel'

help:
	@grep --no-filename --extended-regexp '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-26s\033[0m %s\n", $$1, $$2}'

build: ## Build PHP image
	@docker compose build

install: ## Install Laravel
	@docker compose run --rm php /bin/ash -c $(INSTALL)

start: ## Start containers
	@docker compose up -d

stop: ## Stop and remove containers
	@docker compose down

restart: stop start ## Restart all containers

shell: ## Open shell in PHP container
	@docker compose exec php /bin/ash

test: ## Run tests
	@docker compose run --rm php php artisan test

lint: ## Run linter
	@docker compose run --rm php ./vendor/bin/pint -v --test --preset per
