CONFIG = YAML.load_file(Rails.root.join('config/source_type.yml'))[Rails.env]
VkontakteApi.configure do |config|
  config.app_id       = CONFIG['vk_app_id'] # => '5695095'
  config.app_secret   = CONFIG['vk_secret_key'] # => 'ifwvv1uSMN5DiO68rod4'
  config.redirect_uri = if ['development', 'test'].include?(ENV['RAILS_ENV'])
    'http://localhost:8080/callback'
  else
    'http://localhost:8080/callback'
  end
end
