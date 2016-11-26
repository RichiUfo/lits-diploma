VkontakteApi.configure do |config|
  config.app_id       = Rails.application.config.source_type['vk_app_id']
  config.app_secret   = Rails.application.config.source_type['vk_secret_key']
  config.redirect_uri =
    if %w(development test).include?(ENV['RAILS_ENV'])
      'http://localhost:8080/callback'
    else
      "#{ENV['BASE_URL']}/callback"
    end
end
