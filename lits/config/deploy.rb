# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'application'
set :repo_url, 'git@github.com:somenugget/lits-diploma.git'
set :user, 'application'
set :group, 'application'

set :deploy_to, "/home/#{fetch(:application)}/"
set :repo_tree, 'lits'
set :stage, :production
set :ssh_options, forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub)

set :whenever_command, "(cd #{current_path} && ~/.rvm/bin/rvm default do " \
                       'bundle exec whenever --update-crontab)'
