# Laravel Docker

A [Docker](https://www.docker.com/)-based installer and runtime for the [Laravel](https://laravel.com/) web framework,
with full HTTP/2 and HTTPS support.

Built on top of [Symfony Docker](https://github.com/dunglas/symfony-docker/blob/main/README.md).

## Getting Started

1. [Install Docker Compose](https://docs.docker.com/compose/install/) (v2.10+)
2. Run `docker compose build` to build fresh images
3. Run `docker compose up --pull --wait` to start the project, add custom options for custom start
4. Open `https://localhost` on web browser
   and [accept the auto-generated TLS certificate](https://stackoverflow.com/a/15076602/1352334).
5. Run `docker compose down --remove-orphans` to stop Docker containers.

## Features

* Production, development and CI ready
* Automatic HTTPS (in dev and in prod!)
* HTTP/2, HTTP/3 and [Preload](https://symfony.com/doc/current/web_link.html) support
* [XDebug](https://xdebug.org/) support
* [Vulcain](https://vulcain.rocks) support
* Just 2 services (PHP FPM and Caddy server)

**Enjoy!**

## Docs

1. [Build options](docs/build.md)
2. [Using Symfony Docker with an existing project](docs/existing-project.md)
3. [Deploying in production](docs/production.md)
4. [Debugging with Xdebug](docs/xdebug.md)
5. [TLS Certificates](docs/tls.md)
6. [Using a Makefile](docs/makefile.md)
7. [Troubleshooting](docs/troubleshooting.md)

## License

Laravel Docker is available under the MIT License.

## Credits

Created by [Lorenzo Dessimoni](https://github.com/FunkyOz), based to work of [Symfony Docker](https://github.com/dunglas) by [Kévin Dunglas](https://github.com/dunglas)
