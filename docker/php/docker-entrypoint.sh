#!/bin/sh
set -e

if [ "$1" = 'supervisord' ] || [ "$1" = 'php' ] || [ "$1" = 'artisan' ]; then
	# Install the project the first time PHP is started
	# After the installation, the following block can be deleted
	if [ ! -f composer.json ]; then
		rm -Rf tmp/
		composer create-project "laravel/laravel $LARAVEL_VERSION" tmp --stability="$STABILITY" --prefer-dist --no-progress --no-interaction --no-install --no-scripts

		cd tmp
		cp -Rp . ..
		cd -
		rm -Rf tmp/

        composer run-script post-root-package-install
		composer install --prefer-dist --no-progress --no-interaction
		composer run-script post-create-project-cmd
	fi

	if [ -z "$(ls -A 'vendor/' 2>/dev/null)" ]; then
		composer install --prefer-dist --no-progress --no-interaction
	fi

    if [ "$APP_ENV" = "prod" ]; then
        setfacl -R -m u:www-data:rwX -m u:"$(whoami)":rwX storage
	    setfacl -dR -m u:www-data:rwX -m u:"$(whoami)":rwX storage
    fi
fi

exec docker-php-entrypoint "$@"
