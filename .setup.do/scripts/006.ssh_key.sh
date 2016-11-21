#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

su www-data -c 'mkdir /var/www/.ssh/'
su www-data -c "cp $DIR/../ssh/id_rsa /var/www/.ssh/id_rsa"
su www-data -c "cp $DIR/../ssh/id_rsa.pub /var/www/.ssh/id_rsa.pub"

chmod 0400 /var/www/.ssh/id_rsa
