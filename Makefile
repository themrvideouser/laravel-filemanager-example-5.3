init:
	composer install

	@if [ ! -f .env ];\
		then cp .env.example .env;\
		echo "Copied from .env.example";\
		php artisan key:generate;\
	fi

	php artisan vendor:publish --tag=lfm_public --force
	php artisan vendor:publish --tag=lfm_config --force
	touch database/database.sqlite
	php artisan migrate:refresh --seed

update:
	composer update unisharp/laravel-filemanager
	php artisan vendor:publish --tag=lfm_public --force
	php artisan vendor:publish --tag=lfm_config --force

test:
	@echo "PSR-2 Testing"
	php ./vendor/squizlabs/php_codesniffer/scripts/phpcs --standard=PSR2 vendor/unisharp/laravel-filemanager/src/controllers
	php ./vendor/squizlabs/php_codesniffer/scripts/phpcs --standard=PSR2 vendor/unisharp/laravel-filemanager/src/Events
	php ./vendor/squizlabs/php_codesniffer/scripts/phpcs --standard=PSR2 vendor/unisharp/laravel-filemanager/src/middlewares
	php ./vendor/squizlabs/php_codesniffer/scripts/phpcs --standard=PSR2 vendor/unisharp/laravel-filemanager/src/traits
	@echo "End-To-End Testing"
	sh ./vendor/bin/phpunit vendor/unisharp/laravel-filemanager/tests/ApiTest.php
