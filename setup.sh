#!/bin/bash
(cd ./wp-app/ && git clone https://github.com/debtcollective/wordpress-debtcollective-site.git)
(cd ./wp-app/wp-content/plugins/wp-action-network-events && git clone https://github.com/debtcollective/wp-action-network-events.git)
docker exec --user www-data docker-wordpress_wordpress_1 composer update
docker exec --user www-data -w /var/www/html/wp-content/plugins/wp-action-network-events docker-wordpress_wordpress_1 composer update