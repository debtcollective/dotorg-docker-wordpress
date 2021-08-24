#!/bin/bash
curl -sL https://github.com/debtcollective/wordpress-debtcollective-site/archive/refs/heads/main.zip > /tmp/wp-site.zip
curl -sL https://github.com/debtcollective/wp-action-network-events/archive/refs/heads/main.zip > /tmp/wp-action.zip
unzip /tmp/wp-site.zip -d /tmp/
unzip /tmp/wp-action.zip -d /tmp/
mkdir ./wp-app/wp-content/plugins/wp-action-network-events
cp -rf /tmp/wp-action-network-events-main/* ./wp-app/wp-content/plugins/wp-action-network-events
cp -rf /tmp/wordpress-debtcollective-site-main/* ./wp-app
docker exec -it docker-wordpress_wordpress_1 composer update
docker exec -w /var/www/html/wp-content/plugins/wp-action-network-events docker-wordpress_wordpress_1 composer update