#!/bin/sh --

# create proxysql.cnf from proxysql-template.cnf by
# substituting values read from JSON file containing
# single object with specified keys
env $(jq -r '''@sh "
    DBHOST=\(.HOST)
    DBPORT=\(.PORT)
    DBNAME=\(.NAME)
    DBUSER=\(.USER)
    DBPASS=\(.PASSWORD)
"''' database.json) \
envsubst < proxysql-template.cnf > proxysql.cnf

docker run -p 6033:6033 -d -v \
${PWD}/proxysql.cnf:/etc/proxysql.cnf proxysql/proxysql
