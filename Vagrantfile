# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
  config.vm.provision :shell, path: '.setup/bootstrap.sh'
  config.vm.synced_folder '.', '/var/www/', owner: 'www-data', group: 'www-data'

  config.vm.provider 'virtualbox' do |vb|
    config.vm.box = 'ubuntu/trusty64'
    config.vm.network :forwarded_port, guest: 22, host: 2221, id: "ssh", auto_correct: true
    config.vm.network :forwarded_port, guest: 80, host: 8080, auto_correct: true # Nginx
    config.vm.network :forwarded_port, guest: 5432, host: 54322, auto_correct: true # PostgreSQL

    vb.customize ['modifyvm', :id, '--memory', '4096']
  end
end
