#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
apt-get install -y apt-transport-https ca-certificates

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
apt-get install -y apt-transport-https ca-certificates

# Add Passenger APT repository
sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main > /etc/apt/sources.list.d/passenger.list'
apt-get update

# Install Passenger & Nginx
apt-get install -y nginx-extras passenger

rm /etc/nginx/sites-enabled/*
rm /etc/nginx/sites-available/*

cp ${DIR}/../nginx/nginx.conf /etc/nginx/nginx.conf
cp ${DIR}/../nginx/default /etc/nginx/sites-available/

ln -s /etc/nginx/sites-available/* /etc/nginx/sites-enabled/

service nginx restart
