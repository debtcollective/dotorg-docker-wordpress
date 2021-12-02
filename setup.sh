#!/bin/bash
cp composer.json wp-app/composer.json

# set github token for composer to install the wp-action-network-events repo
docker exec --user www-data -w /var/www/html/ dotorg-docker-wordpress_wordpress_1 composer config --auth github-oauth.github.com "$GITHUB_TOKEN"
docker exec --user www-data -w /var/www/html/ dotorg-docker-wordpress_wordpress_1 composer update
docker exec --user www-data -w /var/www/html/wp-content/themes/dotorg-theme dotorg-docker-wordpress_wordpress_1 composer update
# run the db import script to get the latest db
./import-db.sh