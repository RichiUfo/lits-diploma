#!/usr/bin/env bash

DIR="/var/www/.setup/scripts/"

APP_NAME='lits'
APP_DB_USER=${APP_NAME}
APP_DB_PASS=${APP_DB_USER}
APP_DB_NAME=${APP_DB_USER}
APP_TEST_DB_NAME="${APP_DB_NAME}_test"
PG_VERSION=9.6

echo "$APP_NAME"
echo "=================================="

# for file in ${DIR}*; do
#   echo "=================================="
#   echo "[SH Scripts]: ${file} [START]"
#   . ${file}
#   echo "[SH Scripts]: ${file} [END]"
#   echo "=================================="
# done
