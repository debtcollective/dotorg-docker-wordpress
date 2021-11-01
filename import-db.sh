#!/bin/bash
set -a # automatically export all variables
source .env
set +a
ssh -i "$SSH_KEY_PATH" -f -L 3306:"$MYSQL_HOST":3306 "$SSH_USER"@"$IP_ADDRESS" -p "$PORT" sleep 60 && mysqldump --column-statistics=0 -h 127.0.0.1  -u "$MYSQL_USER" -p"$MYSQL_PASS" "$MYSQL_DB" > wp-data/wp.sql