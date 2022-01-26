# Based on
- [Setup (Kong + Konga) as API Gateway ](https://dev.to/vousmeevoyez/setup-kong-konga-part-2-dan)
- [Using multiple databases with the official PostgreSQL Docker image](https://github.com/mrts/docker-postgresql-multiple-databases)
- [Using Docker Compose to Launch a PostgreSQL Database](https://graspingtech.com/docker-compose-postgresql/)
- [How to easily create a Postgres database in Docker](https://dev.to/andre347/how-to-easily-create-a-postgres-database-in-docker-4moj)
- [Docker Compose + Postgres Docker Entry point init db.d init.sql Permission denied](https://www.onooks.com/docker-compose-postgres-docker-entrypoint-initdb-d-init-sql-permission-denied/)
- [Set up a PostgreSQL server and pgAdmin with Docker](https://linuxhint.com/postgresql_docker/)

# Description
## docker-compose.yml
Docker Compose file
### Run
````
docker network create kong-net
docker-compose up -d --build
````
### Stop
````
docker-compose down
````
### Check
#### Kong
````
curl -i http://localhost:8001/
````
#### PgAdmin
````
curl -i http://localhost:5050/
````
## dockerfile-postgres
Custom Postgres dockerfile to be able to initialize DB by script (see **docker-entrypoint.sh**)
## docker-entrypoint.sh
SQL scripts to initialize DB
Allows combining DBs configuration in single line, for instance:
````
environment:
POSTGRES_USERS: username:password | username2:password
POSTGRES_DATABASES: dbname:username | dbname2:username2
````
## .env
Environment variables definition

see [Environment variables in Compose](https://docs.docker.com/compose/environment-variables/)

## others
### psql connect string format
[Connection Strings](https://www.postgresql.org/docs/current/libpq-connect.html#LIBPQ-CONNSTRING)
````
$ psql postgresql://[user[:password]@][host][:port][,...][/dbname][?param1=value1&...]
````
example:
````
$ psql postgresql://konguser:password@localhost:5432/kongdb
````