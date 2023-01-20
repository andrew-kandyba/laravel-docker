#!/bin/ash

composer install
php artisan key:generate
php artisan optimize:clear
php artisan storage:link
php artisan route:cache
php artisan event:cache
php artisan view:cache

while ! nc -z -v mysql 3306; do echo "Waiting mysql container...:3" && sleep 3; done;
php artisan migrate

php artisan queue:restart
/usr/bin/supervisord -c /etc/supervisor/supervisor.conf

exec "$@"
