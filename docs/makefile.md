# Makefile

Here is a Makefile template. It provides some shortcuts for the most common tasks.
To use it, create a new `Makefile` file at the root of your project. Copy/paste
the content in the template section. To view all the available commands, run `make`.

For example, in the [getting started section](/README.md#getting-started), the
`docker compose` commands could be replaced by:

1. Run `make build` to build fresh images
2. Run `make up` (detached mode without logs)
3. Run `make down` to stop the Docker containers

Of course, this template is basic for now. But, as your application is growing,
you will probably want to add some targets like running your tests.

If you want to run make from within the `php` container, in the [Dockerfile](../Dockerfile),
add:

```diff
gettext \
git \
+make \
```

And rebuild the PHP image.

**PS**: If using Windows, you have to install [chocolatey.org](https://chocolatey.org/)
or use [Cygwin](http://cygwin.com) to use the `make` command. Check out this
[StackOverflow question](https://stackoverflow.com/q/2532234/633864) for more explanations.

## The template

```Makefile
# Executables (local)
DOCKER_COMP = docker compose

# Docker containers
SERVER_CONT = $(DOCKER_COMP) exec php

# Executables
PHP      = $(SERVER_CONT) php
COMPOSER = $(SERVER_CONT) composer
ARTISAN  = $(PHP) artisan

# Misc
.DEFAULT_GOAL = help
.PHONY        : help build up start down logs sh composer vendor sf cc

## —— 🎵 🐳 The Laravel Docker Makefile 🐳 🎵 ——————————————————————————————————
help: ## Outputs this help screen
	@grep -E '(^[a-zA-Z0-9\./_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

## —— Docker 🐳 ————————————————————————————————————————————————————————————————
build: ## Builds the Docker images
	@$(DOCKER_COMP) build --pull --no-cache

up: ## Start the docker hub in detached mode (no logs)
	@$(DOCKER_COMP) up --pull always -d --wait

start: build up ## Build and start the containers

down: ## Stop the docker hub
	@$(DOCKER_COMP) down --remove-orphans

logs: ## Show live logs
	@$(DOCKER_COMP) logs --tail=0 --follow

sh: ## Connect to the Server container
	@$(SERVER_CONT) sh

## —— Composer 🧙 ——————————————————————————————————————————————————————————————
composer: ## Run composer, pass the parameter "c=" to run a given command, example: make composer c='req guzzlehttp/guzzle'
	@$(eval c ?=)
	@$(COMPOSER) $(c)

vendor: ## Install vendors according to the current composer.lock file
vendor: c=install --prefer-dist --no-dev --no-progress --no-scripts --no-interaction
vendor: composer

## —— Laravel 🎵 ———————————————————————————————————————————————————————————————
artisan: ## List all Artisan commands or pass the parameter "c=" to run a given command, example: make artisan c=about
	@$(eval c ?=)
	@$(ARTISAN) $(c)

cc: c=c:c ## Clear the cache
cc: artisan
```
