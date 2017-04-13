# Etherpad Lite

Etherpad Lite using Docker Compose and a data volume for the database data including daily backups.

In `docker-compose.yml` create a password for `ETHERPAD_ADMIN_PASSWORD`. This allows you to login
using the `admin` user on `https://<your-domain>/admin` to change settings.

Installation on first use:
- `cd docker`
- `sudo docker-compose up -d`
- Run `sudo docker-compose logs` and wait till MySQL prints out a line with the generated password, it contains the phrase `GENERATED ROOT PASSWORD:`
- Use this password for `ETHERPAD_DB_PASSWORD` in `docker-compose.yml`
- `sudo docker-compose down --rmi all`
- `sudo docker-compose up -d`
- `docker_c-etherpad-lite_1` will not work for a minute or so and keeps restarting until `docker_c-etherpad-lite-mysql_1` is fully started
- Etherpad Lite is now accessible via port 80 of `docker_c-etherpad-lite_1`

Installation when you have a backup:
- Use the password that was created for the MySQL database you are going to import for `ETHERPAD_DB_PASSWORD` in `docker-compose.yml`
- Make sure the backup .sql file (e.g., `gunzip` the latest of the backupped .gz files) is located in `docker/docker-entrypoint-initdb.d`, so MySQL can load it on start
- `cd docker`
- `sudo docker-compose up -d`
- `docker_c-etherpad-lite_1` will not work for a minute or so and keeps restarting until `docker_c-etherpad-lite-mysql_1` is fully started
- Etherpad Lite is now accessible via port 80 of `docker_c-etherpad-lite_1`

Create backups:
- Set your MySQL database password for `DB_PASSWORD` in `docker/backup.sh`
- To run manually
  - `cd docker`
  - `sudo ./backup.sh`
- To set a daily cronjob at 05:52
  - `sudo crontab -e` and add the following line (change the path below to your `etherpad-lite/docker` directory path)
  - `52 5 * * * (cd <PATH_TO_etherpad-lite/docker> && sudo ./backup.sh)`
