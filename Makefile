include .env

.DEFAULT_GOAL := help

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

console: ## Run bash (PHP)
	docker-compose exec php /bin/bash

up: ## Up Docker-project
	docker-compose up -d

down: ## Down Docker-project
	docker-compose down --remove-orphans

build: ## Build Docker-project
	docker-compose build --no-cache

bitrix-setup: create-dir ## Download bitrixsetup.php file to the site path
	wget http://www.1c-bitrix.ru/download/scripts/bitrixsetup.php -O ${SITE_PATH}/bitrixsetup.php

bitrix-restore: create-dir ## Download restore.php file to the site path
	wget http://www.1c-bitrix.ru/download/scripts/restore.php -O ${SITE_PATH}/restore.php

create-dir: ## Create site path
	mkdir -p ${SITE_PATH}

default: help
