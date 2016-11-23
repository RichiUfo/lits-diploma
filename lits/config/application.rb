require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    config.time_zone = 'Kyiv'

    config.eager_load_paths << Rails.root.join('lib')
  end
end
