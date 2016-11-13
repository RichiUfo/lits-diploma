Koala::Facebook::OAuth.class_eval do
  def initialize_with_default_settings(*args)
    raise "application id and/or secret are not specified in the envrionment" unless ENV['FB_APP_ID'] && ENV['FB_SECRET_KEY']
    initialize_without_default_settings(ENV['377422892596265'].to_s, ENV['6c1f9aa39c131dc2ec736ca595955d6a'].to_s, args.first)
  end

  alias_method_chain :initialize, :default_settings
end