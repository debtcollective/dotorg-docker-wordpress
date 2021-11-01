# Dotorg Docker

Our own flavor of Wordpress for dotorg.

## Setup
Rename `env.example` to `.env`

**Environment Variables**
The easiest way to run the app is by using [Doppler](https://www.doppler.com/). Ask to be added to the project.

You can install it by running `brew install dopplerhq/cli/doppler`. You can can check the [Doppler docs here](https://docs.doppler.com/docs/enclave-installation#local-development), but below is the gist of commands you need to run.

```bash
doppler login
doppler setup
```

To use Doppler to inject environment variables, prepend `doppler run` to commands. 

```bash
doppler run docker-compose up
```

We also support [Dotenv](#dotenv) to configure environment variables. But you will need to supply all the secrets manually.

## Pull latest DB

`brew install mysql@5.7`

run the following command if brew doesn't add this to your path and mysqldump isn't found. Ensure the version numbers are the same.
`export PATH=/usr/local/Cellar/mysql@5.7/5.7.35/bin:$PATH`

You will need to have an SSH key in order to connect to the database and set the path of the environment variable SSH_KEY_PATH to the proper location.

`./import-db.sh`

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


then in another terminal run: `bash setup.sh`


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
