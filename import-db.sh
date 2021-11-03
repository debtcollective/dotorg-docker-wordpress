#!/bin/bash
set -a # automatically export all variables
source .env
set +a
ssh -i "$SSH_KEY_PATH" -f -L 3306:"$MYSQL_HOST":3306 "$SSH_USER"@"$IP_ADDRESS" -p "$PORT" sleep 60 && mysqldump --column-statistics=0 -h 127.0.0.1  -u "$MYSQL_USER" -p"$MYSQL_PASS" "$MYSQL_DB" > wp-data/wp.sql
# restart container to load in new db
docker restart dotorg-docker_db_1 
sleep 5
docker exec --user root -w / dotorg-docker_db_1 bash -c " mysql -u root -p'$DB_USER_PASSWORD' '$DB_NAME' < /docker-entrypoint-initdb.d/wp.sql"
# change site url and homepage db fields
docker exec --user root -w / dotorg-docker_db_1 bash -c "mysql -u '$DB_NAME' -p'$DB_USER_PASSWORD' '$DB_NAME' -e \"UPDATE wp_options SET option_value='http://localhost:8000' WHERE option_name='siteurl';\""
docker exec --user root -w / dotorg-docker_db_1 bash -c "mysql -u '$DB_NAME' -p'$DB_USER_PASSWORD' '$DB_NAME' -e \"UPDATE wp_options SET option_value='http://localhost:8000' WHERE option_name='home';\""
# adjust for discrepancy in database and active site functionality theme and dotorg theme
docker exec --user root -w /var/www/html/ dotorg-docker-wordpress_1 bash -c "wp theme activate dotorg-theme"
docker exec --user root -w /var/www/html/ dotorg-docker-wordpress_1 bash -c "wp plugin activate dotorg-site-functionality"