# Virtual machile for Ruby On Rails 5 development

## Requirements
* [VirtualBox](https://www.virtualbox.org)
* [Vagrant](http://vagrantup.com)

## How To Build The Virtual Machine
You can building the virtual machine using this commands:
```sh
git clone https://github.com/somenugget/rails5-vagrant.git
cd rails5-vagrant
vagrant up
```
or install it with rails 4.2 (works more stable)
```sh
git clone -b rails4 https://github.com/somenugget/rails5-vagrant.git rails4-vagrant
cd rails4-vagrant
vagrant up
```
Connect to your machine via _ssh_
```sh
vagrant ssh
Welcome to Ubuntu 14.04.5 LTS (GNU/Linux 3.13.0-92-generic x86_64)
```

Select _www-data_ user. 
```sh
sudo su www-data
```    
Move to _/var/www_ directory. Here is a place, where all your code are stored
```sh
cd /var/www
```    
There is one bug with this machine, so before start working you need to do this:
```sh
source /var/www/.rvm/scripts/rvm
```
Ok. Now you are ready to enjoy ruby.
If you want just to test ruby, you can do this in your command line:
```sh
ruby -v
```
or this
```sh
ruby -e 'puts "Hello, World"'
```
or this
```sh
echo 'puts "Hello, World"' > hello.rb
ruby hello.rb
rm hello.rb
```

If you want to test Ruby On Rails, run run this commands:
```sh
mkdir /var/www/app
cd /var/www/app
rails new .
```
Wait the installation is complete, and run the server
```sh
rails server -b '0.0.0.0'
```
You have to see this message
```sh
=> Booting Puma
=> Rails 5.0.0.1 application starting in development on http://0.0.0.0:3000
=> Run `rails server -h` for more startup options
Puma starting in single mode...
* Version 3.6.0 (ruby 2.3.1-p112), codename: Sleepy Sunday Serenity
* Min threads: 5, max threads: 5
* Environment: development
* Listening on tcp://0.0.0.0:3000
Use Ctrl-C to stop
```
Now you can open your rails app in the browser at http://localhost:3001



## Possible errors
_/var/www/.rvm/rubies/ruby-2.3.1/lib/ruby/2.3.0/fileutils.rb:253:in `mkdir': Permission denied @ dir_s_mkdir - /run/user/1000/spring-33 (Errno::EACCES)_
Just run 
```sh
unset XDG_RUNTIME_DIR
```
