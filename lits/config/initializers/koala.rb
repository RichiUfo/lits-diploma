module Facebook
  APP_ID = Rails.application.config.source_type['fb_app_id']
  SECRET = Rails.application.config.source_type['fb_secret_key']
end

Koala::Facebook::OAuth.class_eval do
  def initialize_with_default_settings(*args)
    case args.size
    when 0, 1
      unless Facebook::APP_ID && Facebook::SECRET
        raise 'application id and/or secret are not specified in the config'
      end

      initialize_without_default_settings(Facebook::APP_ID.to_s, Facebook::SECRET.to_s, args.first)
    when 2, 3
      initialize_without_default_settings(*args)
    end
  end

  alias_method :initialize_without_default_settings, :initialize
  alias_method :initialize, :initialize_with_default_settings
end
