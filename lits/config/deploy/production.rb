server '82.196.1.39', user: 'application',
                      roles: %w{app db web},
                      ssh_options: {
                        user: 'application',
                        keys: %w(/var/www/.ssh/id_rsa),
                        forward_agent: false,
                        auth_methods: %w(password publickey)
                      }
