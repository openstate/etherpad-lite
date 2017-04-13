#!/bin/bash
MYSQL_CONTAINER="docker_c-etherpad-lite-mysql_1"
DB_PASSWORD="<YOUR_DB_PASSWORD>"
NETWORK="docker_etherpad-lite"
CMD="mysqldump -h $MYSQL_CONTAINER -u root --password=$DB_PASSWORD --all-databases --ignore-table=mysql.event | gzip > /docker-entrypoint-initdb.d/latest-mysqldump-daily.sql.gz ; \
cp -p /docker-entrypoint-initdb.d/latest-mysqldump-daily.sql.gz /docker-entrypoint-initdb.d/`(date +%A)`-mysqldump-daily.sql.gz"

docker run --rm --network $NETWORK -v `pwd`/docker-entrypoint-initdb.d:/docker-entrypoint-initdb.d:rw mysql bash -c "$CMD"
