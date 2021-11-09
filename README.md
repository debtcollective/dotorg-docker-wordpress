# Dotorg Docker

Our own flavor of Wordpress for dotorg.

## Setup

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

Rename `env.example` to `.env` and set the following variables.

- SSH_KEY_PATH: Path to SSH identity file for server logging
- SSH_USER: User to connect to server
- IP_ADDRESS: IP address of the remote server
- PORT: Remote server port
- MYSQL_HOST: Hostname for MySQL
- MYSQL_USER: User for MySQL
- MYSQL_PASS: Password for Mysql User 
- MYSQL_DB: MySQL Database to connect to
- GITHUB_TOKEN: Github personal token to pull repos from composer


## Pull latest DB

`brew install mysql@5.7`

run the following command if brew doesn't add this to your path and mysqldump isn't found. Ensure the version numbers are the same.

`brew info mysql@5.7`

Then export the path as below from the mysql path output from brew info.

`export PATH=/usr/local/Cellar/mysql@5.7/5.7.35/bin:$PATH`

You will need to have an SSH key in order to connect to the database and set the path of the environment variable SSH_KEY_PATH to the proper location. If you are using doppler set the staging key path to `~/.ssh/dc_aws_test` and production key path to `~/.ssh/dc_aws_prod`

This command will also be run in the initial `setup.sh` script but can be run separately to update the database:

`doppler run ./import-db.sh`

## Run Locally

### Starting containers

`doppler run docker-compose up`

This will create the containers and populate the database with the given dump. You may set your host entry and change it in the database, or you simply overwrite it in `wp-config.php` by adding:

```
define('WP_HOME','http://localhost:8000');
define('WP_SITEURL','http://localhost:8000');
```

Two new folders will be created.

* `wp-data` – used to store and restore database dumps
* `wp-app` – the location of your WordPress application


then in another terminal run: 

`doppler run ./setup.sh`


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

To remove all the container volumes use:

```
docker volume rm dbdata
docker volume rm dotorg-docker_wordpress_dbdata
```

## phpMyAdmin

Navigate to: `http://localhost:8080/`.
Login with username `root` and password `<DB_ROOT_PASSWORD>` env variable

## Build Docker Image

Run `make` in the root directory to build a docker image using the makefile

