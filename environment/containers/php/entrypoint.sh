#!/bin/ash

composer install

# php artisan migrate
php artisan key:generate
php artisan optimize:clear
php artisan storage:link
php artisan route:cache
php artisan event:cache
php artisan view:cache

php artisan queue:restart

/usr/bin/supervisord -c /etc/supervisor/supervisor.conf

exec "$@"
