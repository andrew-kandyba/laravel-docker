# laravel-docker


## :pizza: Requirments
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

### 3. Build the docker images
```bash
> make build
```
### 3. Run containers
```bash
> make start
```

### Make
To see a list of available commands, run :
```bash
> make
```

## :pizza: Config
| Name | Default |Comment       |
| ------ | ------ | ------ |
|  HTTP_PORT      |  80      |        |
|  HTTPS_PORT      |   443     |        |
|  IMAGE_CONTEXT      |   $(PWD)/environment/containers/.     |        |
|  IMAGE_LABEL      |   development     |        |
|  LARAVEL_DIRECTORY      |   $(PWD)/application     |        |
|  LOCALHOST_DOMAIN      |   laravel-app.localhost     |        |
|  MYSQL_DATABASE      |   laravel-app-db     |        |
|  MYSQL_PORT      |   3306     |        |
|  MYSQL_ROOT_PASSWORD      |   i_am_root     |        |
|  PROJECT      |   laravel-app     |        |
