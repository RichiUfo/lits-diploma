VkontakteApi.configure do |config|
  config.app_id       = '5695095'
  config.app_secret   = 'ifwvv1uSMN5DiO68rod4'
  config.redirect_uri = if ['development', 'test'].include?(ENV['RAILS_ENV'])
    'http://localhost:8080/callback'
  else
    'http://localhost:8080/callback'
  end
end
