# laravel-docker
A sandbox for developing [laravel](https://laravel.com) applications.

#### Features

* Automatic HTTPS ([mkcert required]())
* HTTP/2 support
* [XDebug](docs/xdebug.md) and Supervisord integration
* Clean and well-structured configuration.
* Easy setup with a few commands.
* Trusted base images.

## :triangular_flag_on_post: Requirments
* [mkcert](https://github.com/FiloSottile/mkcert)
* [docker (v19.03.12 or late)](https://docs.docker.com/engine/install/ubuntu/)
* [docker-compose (v1.26.0 or late)](https://docs.docker.com/compose/install/)

## :dancer: Usage

### 1. Clone the repository
```bash
> git clone git@github.com:andrew-kandyba/laravel-docker.git
```

### 2. Create a laravel application skeleton
```bash
> make build-laravel
```
> By default laravel project will be created into `./application` directory. You can change this via `$LARAVEL_DIRECTORY` variable.
>
> Please see [config](#pizza-config) and [build-laravel](https://github.com/andrew-kandyba/laravel-docker/blob/main/Makefile#L31-L35) for more info.

### 3. Build the docker images
```bash
> make build
```
> By default will be created next images: `laravel-app/mysql`, `laravel-app/nginx`, `laravel-app/php`. \
> You can change image repository part (`laravel-app...`) via `$PROJECT` variable.
>
> Please see [config](#pizza-config) and [build](https://github.com/andrew-kandyba/laravel-docker/blob/81ae70ec6729a3aac24efaa6581bc0f7b051e2c8/Makefile#L16-L29) for more info.

### 4. Run containers
```bash
> make start
```
> By default will be created next containers: `laravel-app-mysql`, `laravel-app-nginx`, `laravel-app-php`. \
> You can change container name (`laravel-app...`) via `$PROJECT` variable. \
> Also will be created a ssl certificate (need [mkcert](https://github.com/FiloSottile/mkcert)) for `laravel-app.localhost`, you can set other domain via `$LOCALHOST_DOMAIN` variable.
>
> Please see [config](#pizza-config) and [start](https://github.com/andrew-kandyba/laravel-docker/blob/main/Makefile#L37-L39) + [.generate-ssl](https://github.com/andrew-kandyba/laravel-docker/blob/ea072ba1f92de7db625829394764c8eac631fdcf/Makefile#L48-L51) for more info.

### 5. Stop containers
```bash
> make stop
```
> Applications containers + resources (ssl, volumes...etc) will be stopped and deleted.
>
> Please see [stop](https://github.com/andrew-kandyba/laravel-docker/blob/main/Makefile#L41-L43) for more info.

### Make
To see a list of available commands:
```bash
> make
```

## :pizza: Config
[`./docker.env`](https://github.com/andrew-kandyba/laravel-docker/blob/main/docker.env) - docker environment variables

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
