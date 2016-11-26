ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
# require 'database_cleaner'
require 'factory_girl_rails'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  Shoulda::Matchers.configure do |shoulda_config|
    shoulda_config.integrate do |with|
      # Choose a test framework:
      with.test_framework :rspec

      # Or, choose the following (which implies all of the above):
      with.library :rails
    end
  end
end
