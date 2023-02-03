# laravel-docker
[![ci](https://github.com/andrew-kandyba/laravel-docker/actions/workflows/ci.yml/badge.svg)](https://github.com/andrew-kandyba/laravel-docker/actions/workflows/ci.yml)&nbsp; [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

A sandbox for developing [laravel](https://laravel.com) applications. 

```bash
> php: 8.2.1-fmp-alpine.3.17
> nginx: 1.23-3-alpine
> mysql: 8.0.32
```

<details><summary><i>PHP modules</i></summary>

```bash
> 🐼 laravel-docker git:(main) ✗ docker exec -ti laravel-app-php /usr/local/bin/php -m

[PHP Modules]
apcu
bcmath
Core
ctype
curl
date
dom
fileinfo
filter
ftp
hash
iconv
intl
json
libxml
mbstring
mysqlnd
openssl
pcntl
pcre
PDO
pdo_mysql
pdo_sqlite
Phar
posix
random
readline
Reflection
session
SimpleXML
sodium
SPL
sqlite3
standard
tokenizer
xdebug
xml
xmlreader
xmlwriter
Zend OPcache
zip
zlib

[Zend Modules]
Xdebug
Zend OPcache
```
</details>

#### Features

* Automatic HTTPS.
* HTTP/2 support.
* [XDebug](docs/xdebug.md) integration.
* Clean and easy setup.
* Well-structured.

## :cop: Requirments
* [mkcert](https://github.com/FiloSottile/mkcert)
* [composer](https://github.com/composer/composer)
* [docker (v19.03.12 or late)](https://docs.docker.com/engine/install/ubuntu/)
* [docker-compose (v1.26.0 or late)](https://docs.docker.com/compose/install/)

## :dancer: Usage

### 1. Clone the repository and remove needless directories
```bash
> git clone git@github.com:andrew-kandyba/laravel-docker.git

> 🐼 laravel-docker git:(main) rm -rf .git/
> 🐼 laravel-docker git:(main) rm -rf .github/
```

### 2. Create a laravel application skeleton
```bash
> make build-laravel
```
Fresh laravel project will be created into `./application` directory, it can be changed via `$LARAVEL_DIRECTORY`.

>**Note**
Please see [config](#pizza-config) and [build-laravel](https://github.com/andrew-kandyba/laravel-docker/blob/HEAD/Makefile#L34-L38) for more info.

### 3. Build the docker images
```bash
> make build
```
Will be created: `laravel-app/mysql`, `laravel-app/nginx`, `laravel-app/php`.
```bash
> 🐼 laravel-docker git:(main) ✗ docker images

REPOSITORY          TAG           IMAGE ID       CREATED          SIZE
laravel-app/php     development   f8cde6e5a0f7   43 minutes ago   122MB
laravel-app/nginx   development   5ca2bb4b6959   46 minutes ago   13.8MB
laravel-app/mysql   development   4b49e5f0f347   46 minutes ago   517MB
```
You may change image repository part (`laravel-app...`) via `$PROJECT`.
>**Note**
Please see [config](#pizza-config) and [build](https://github.com/andrew-kandyba/laravel-docker/blob/HEAD/Makefile#L16-L32) for more info.

### 4. Run containers
```bash
> make start
```
Will be created: `laravel-app-mysql`, `laravel-app-nginx`, `laravel-app-php`.
```bash
> 🐼 laravel-docker git:(main) ✗ docker ps --format "table {{.Names}}\t{{.Ports}}\t{{.Image}}"
      
NAMES               PORTS                                      IMAGE
laravel-app-nginx   0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp   laravel-app/nginx:development
laravel-app-php     9000/tcp                                   laravel-app/php:development
laravel-app-mysql   3306/tcp, 33060/tcp                        laravel-app/mysql:development
```
You may change container name (`laravel-app...`) via `$PROJECT`. \
Also will be created a ssl certificate (need [mkcert](https://github.com/FiloSottile/mkcert)) for `laravel-app.localhost`, it can be changed via `$LOCALHOST_DOMAIN`.
>**Note**
Please see [config](#pizza-config) and [start](https://github.com/andrew-kandyba/laravel-docker/blob/HEAD/Makefile#L40-L42) + [.generate-ssl](https://github.com/andrew-kandyba/laravel-docker/blob/HEAD/Makefile#L51-L54) for more info.

### 5. Stop containers
```bash
> make stop
```
Applications containers + resources (ssl, volumes...etc) will be stopped and deleted.
>**Note**
Please see [stop](https://github.com/andrew-kandyba/laravel-docker/blob/HEAD/Makefile#L44-L46) for more info.

### Make
To see a list of available commands:
```bash
> make

build           Building application images.
build-laravel   Building laravel-app skeleton.
start           Create and start application containers.
stop            Stop and remove containers and resources.
shell           Get shell inside php container.
```

## :pizza: Config
[`./laravel-env.example`](https://github.com/andrew-kandyba/laravel-docker/blob/main/laravel-env.example) - laravel application config. \
[`./docker.env`](https://github.com/andrew-kandyba/laravel-docker/blob/main/docker.env) - environment variables.

| Name | Default |Comment       |
|:------|:------|:------|
|  HTTP_PORT      |  80      | Host mapped port (nginx).       |
|  HTTPS_PORT      |   443     | Host mapped port (nginx).       |
|  IMAGE_CONTEXT      |   `$(PWD)/environment/containers/.`     | Docker build context     |
|  IMAGE_LABEL      |   development     | Docker build target |
|  LARAVEL_DIRECTORY      |   `$(PWD)/application`     | Laravel app directory       |
|  LOCALHOST_DOMAIN      |   laravel-app.localhost     | Application domain (mkcert)       |
|  MYSQL_DATABASE      |   laravel-app-db     | Application database (mysql)       | 
|  MYSQL_PORT      |   3306     | Application database port (mysql)       |
|  MYSQL_ROOT_PASSWORD      |   i_am_root     | Application database password (mysql)        |
|  PROJECT      |   laravel-app     | Project label (used by for images/containers naming)      |
