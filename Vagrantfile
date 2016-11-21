# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty64'

  config.vm.provider :virtualbox do |vb|
    config.vm.provision :shell, path: '.setup/bootstrap.sh',
                                env: { PROVIDER: 'do' }
    config.vm.synced_folder '.', '/var/www/', owner: 'www-data',
                                              group: 'www-data'
    config.vm.network :forwarded_port, guest: 22,
                                       host: 2221,
                                       id: 'ssh',
                                       auto_correct: true
    config.vm.network :forwarded_port, guest: 80,
                                       host: 8080,
                                       auto_correct: true
    config.vm.network :forwarded_port, guest: 5432,
                                       host: 54322,
                                       auto_correct: true

    vb.customize ['modifyvm', :id, '--memory', '2048',
                  '--paravirtprovider', 'kvm', '--cpus', '2']
  end

  # config.vm.define 'events', primary: false do |do_config|
  #   do_config.vm.box = 'ubuntu/trusty64'
  #   do_config.vm.provision :shell, path: '.setup.do/bootstrap.sh',
  #                                  env: { PROVIDER: 'do' }
  #   do_config.vm.synced_folder(
  #     '.',
  #     '/var/www/',
  #     owner: 'www-data',
  #     group: 'www-data',
  #     rsync__exclude: %w(.bundle .tmp .gem/ .passenger .rvm .ssh .vagrant),
  #     rsync__args: %w(--verbose --archive --delete -z --links)
  #   )

  #   do_config.ssh.private_key_path = '~/.ssh/id_rsa'

  #   do_config.vm.provider :digital_ocean do |provider|
  #     provider.token = File.read('.do_token')
  #     provider.size = '512mb'
  #     provider.image = 'ubuntu-14-04-x64'
  #     provider.region = 'ams2'
  #   end

  #   do_config.vm.post_up_message = 'It seems that' \
  #     'you had bootstraped your app to Digitalocean.' \
  #     "\nDon`t forget to change DB password." \
  #     "\nDon`t forget to set right application environment"
  # end
end
