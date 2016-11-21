#!/usr/bin/env bash

cd ~
rm -rf /var/www/.rvm
curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -sSL https://get.rvm.io | bash -s stable --rails
echo '/bin/bash --login' >> ~/.bashrc
source ~/.rvm/scripts/rvm
rvm autolibs disable
rvm reload
rvm install ruby-2.3.1
rvm --default use ruby-2.3.1

gem install rake
gem install bundler
gem install rails

cd /var/www/lits
bundle install
rails db:migrate
rails db:seed
rake receive_events:run
