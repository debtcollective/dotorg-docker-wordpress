FROM wordpress:latest

# Add sudo in order to run wp-cli as the www-data user
RUN apt-get update && apt-get install -y sudo less vim unzip git

# Add WP-CLI
RUN curl -o /bin/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
COPY wp-su.sh /bin/wp
RUN chmod +x /bin/wp-cli.phar /bin/wp

# Add PHP Composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN composer self-update 1.10.22

# Setup theme and plugins
COPY clone-repos.sh /
RUN bash /clone-repos.sh