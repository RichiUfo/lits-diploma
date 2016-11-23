#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

su application -c 'mkdir /home/application/.ssh/'
su application -c "cp $DIR/../ssh/id_rsa /home/application/.ssh/id_rsa"
su application -c "cp $DIR/../ssh/id_rsa.pub /home/application/.ssh/id_rsa.pub"

chmod 0400 /home/application/.ssh/id_rsa
