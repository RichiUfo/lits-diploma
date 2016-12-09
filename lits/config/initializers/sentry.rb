Raven.configure do |config|
  config.dsn = ENV['SENTRY_DNS']
  config.environments = %w(production)
end
