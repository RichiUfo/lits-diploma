#!/usr/bin/env bash

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

apt-get update
apt-get -y upgrade

packageList=(
    build-essential git-core curl openssl libssl-dev
    libcurl4-openssl-dev zlib1g zlib1g-dev libreadline-dev
    libreadline6 libreadline6-dev libyaml-dev libxml2-dev
    libxslt1-dev python-software-properties libffi-dev
    libgdm-dev libncurses5-dev automake autoconf libtool
    bison libpq-dev libc6-dev libgmp-dev libsqlite3-dev nodejs
)
apt-get install -y ${packageList[@]}

chmod 775 -R /var/www/.setup/www-data
su - www-data -c '/var/www/.setup/www-data/rvm.sh'
