#!/bin/bash
if [ "$ENVIRONMENT" == "production" ]; then
	curl -sL https://github.com/debtcollective/wordpress-debtcollective-site/archive/refs/heads/main.zip > /tmp/wp-site.zip
	curl -sL https://github.com/debtcollective/wp-action-network-events/archive/refs/heads/main.zip > /tmp/wp-action.zip
	unzip /tmp/wp-site.zip -d /tmp/
	unzip /tmp/wp-action.zip -d /tmp/
	mkdir /usr/src/wordpress/wp-content/plugins/wp-action-network-events
	cp -rf /tmp/wp-action-network-events-main/* /usr/src/wordpress/plugins/wp-action-network-events
	cp -rf /tmp/wordpress-debtcollective-site-main/* /usr/src/wordpress/
	cd /var/www/html && composer update
elif [ "$ENVIRONMENT" == "staging" ]; then
	curl -sL https://github.com/debtcollective/wordpress-debtcollective-site/archive/refs/heads/staging.zip > /tmp/wp-site.zip
	curl -sL https://github.com/debtcollective/wp-action-network-events/archive/refs/heads/staging.zip > /tmp/wp-action.zip
	unzip /tmp/wp-site.zip -d /tmp/
	unzip /tmp/wp-action.zip -d /tmp/
	mkdir /usr/src/wordpress/wp-content/plugins/wp-action-network-events
	cp -rf /tmp/wp-action-network-events-staging/* /usr/src/wordpress/plugins/wp-action-network-events
	cp -rf /tmp/wordpress-debtcollective-site-staging/* /usr/src/wordpress/
	cd /var/www/html && composer update
elif [ "$ENVIRONMENT" == "development" ]; then
	curl -sL https://github.com/debtcollective/wordpress-debtcollective-site/archive/refs/heads/development.zip > /tmp/wp-site.zip
	curl -sL https://github.com/debtcollective/wp-action-network-events/archive/refs/heads/development.zip > /tmp/wp-action.zip
	unzip /tmp/wp-site.zip -d /tmp/
	unzip /tmp/wp-action.zip -d /tmp/
	mkdir /usr/src/wordpress/wp-content/plugins/wp-action-network-events
	cp -rf /tmp/wp-action-network-events-development/* /usr/src/wordpress/plugins/wp-action-network-events
	cp -rf /tmp/wordpress-debtcollective-site-development/* /usr/src/wordpress/
	cd /var/www/html && composer update
fi