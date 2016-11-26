require 'koala'
require 'devise/orm/active_record'

Devise.setup do |config|
  source_type_config = Rails.application.config.source_type

  config.secret_key = 'fe7229a10b1de70a813cc9852b397f65d23d19a759b4dd66ff' +
                      'c934dd4978d847a17b773e3ae9efb2d11b1a8021af662deed0' +
                      '0fb01b278c18297d835a4d895366'
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 11
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.reset_password_within = 6.hours

  config.sign_out_via = :delete
  config.omniauth :facebook,  
                  source_type_config['fb_app_id'], 
                  source_type_config['fb_secret_key'], 
                  image_size: 'small', 
                  scope: 'email', 
                  info_fields: 'email, name'
  config.omniauth :vkontakte, 
                  source_type_config['vk_app_id'], 
                  source_type_config['vk_secret_key'], 
                  image_size: 'small', 
                  scope: 'email,public_profile', 
                  info_fields: 'email, first_name, last_name'
end
