# docker-wordpress

Our own flavor of Wordpress.

## Setup
Rename `env.example` to `.env`

## Pull latest DB

`brew install mysql@5.7`

run the following command if brew doesn't add this to your path and mysqldump isn't found. Ensure the version numbers are the same.
`export PATH=/usr/local/Cellar/mysql@5.7/5.7.35/bin:$PATH`

`./export.sh`

## Run Locally

### Starting containers

`docker-compose up`

This will create the containers and populate the database with the given dump. You may set your host entry and change it in the database, or you simply overwrite it in `wp-config.php` by adding:

```
define('WP_HOME','http://localhost:8000');
define('WP_SITEURL','http://localhost:8000');
```

Two new folders will be created.

* `wp-data` – used to store and restore database dumps
* `wp-app` – the location of your WordPress application


then in another terminal run: `bash clone-repos-local.sh`


The containers are now built and running. You should be able to access the WordPress installation with the configured IP in the browser address. By default it is `http://localhost:8000`.

### Stopping containers

```
docker-compose stop
```

### Removing containers

To stop and remove all the containers use the`down` command:

```
docker-compose down
```

## phpMyAdmin

Navigate to: `http://localhost:8080/`.
Login with username `root` and password `<DB_ROOT_PASSWORD>` env variable
