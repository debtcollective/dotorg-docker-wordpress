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

`docker-compose up`

This will create the containers and populate the database with the given dump. You may set your host entry and change it in the database, or you simply overwrite it in `wp-config.php` by adding:

```
define('WP_HOME','http://localhost:8000');
define('WP_SITEURL','http://localhost:8000');
```

then in another terminal run: `bash clone-repos-local.sh`

navigate to: http://localhost:8000/

## phpMyAdmin

navigate to: http://localhost:8080/
login with username `root` and password `<DB_ROOT_PASSWORD>` env variable
