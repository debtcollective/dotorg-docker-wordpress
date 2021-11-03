#!/bin/bash
# clone DC repos
(cd ./wp-app/wp-content/themes/ && git clone https://github.com/debtcollective/dotorg-theme.git)
(cd ./wp-app/wp-content/plugins/ && git clone https://github.com/debtcollective/dotorg-site-functionality.git)
(cd ./wp-app/wp-content/plugins/ && git clone https://github.com/debtcollective/wp-action-network-events.git)
cp composer.json wp-app/composer.json

# set github token for composer to install the wp-action-network-events repo
docker exec --user www-data -w /var/www/html/ docker-wordpress_wordpress_1 composer config --auth github-oauth.github.com "$GITHUB_TOKEN"
docker exec --user www-data -w /var/www/html/ docker-wordpress_wordpress_1 composer update
docker exec --user www-data -w /var/www/html/wp-content/themes/dotorg-theme docker-wordpress_wordpress_1 composer update
# run the db import script to get the latest db
./import-db.sh