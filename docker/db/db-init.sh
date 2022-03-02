#!/bin/bash

set -e
set -u

function create_user_and_database() {
  re="^([^:]+):(.*):(.*)$"
  [[ $1 =~ $re ]] && database="${BASH_REMATCH[1]}" && user="${BASH_REMATCH[2]}" && password="${BASH_REMATCH[3]}"

	echo "  Creating user '$user' and database '$database'"

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
      CREATE USER $user WITH PASSWORD '$password';
      CREATE DATABASE $database;
      GRANT ALL PRIVILEGES ON DATABASE $database TO $user;
EOSQL
}

if [ -n "$DB_CONF" ]; then
	echo "Multiple database creation requested: $DB_CONF"
	for db in $(echo $DB_CONF | tr ',' ' '); do
		create_user_and_database $db || continue
	done
	echo "Multiple databases created"
fi
