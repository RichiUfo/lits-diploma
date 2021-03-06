require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    config.source_type = config_for :source_type

    config.time_zone = 'Kyiv'

    config.eager_load_paths << Rails.root.join('lib')

    config.app_name = 'WillGo'
  end
end
