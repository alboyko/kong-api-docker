# Overview
Before running set up KONG_LICENSE_DATA environment variable (see .env)

## postgres
localhost:5432 (postgres:password, ...)
## pgadmin
localhost:6060 (postgres:password)

to connect to PG server use {docker host IP}
## kong
API exposed: localhost:8000

admin API: localhost:8001 (RBAC token)

admin UI: localhost:8002 (kong_admin:password)

## keycloak
admin UI, admin API: localhost:7070 (admin:password)
## wiremock
http://{docker-host}:5050/{wiremock endpoint}
## deck
update DECK_HEADERS=kong-admin-token:... and rerun

use {endpoint} in docker-compose.yaml to call command. by default "deck ping"

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
curl -i http://localhost:6060/
````
## dockerfile-postgres
Custom Postgres dockerfile to be able to initialize DB by script (see **docker-entrypoint.sh**)
## db-init.sh
SQL scripts to initialize DBs

Allows combining DBs configuration in single line, for instance:
````
environment:
DB_CONF: dbname:username:password | dbname2:username2:password2
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
