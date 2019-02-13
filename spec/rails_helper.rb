# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?

# Require testing suite dependencies
require 'rspec/rails'
require 'capybara/rspec'

# Require spec support files
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

# Check for pending migrations and apply them before running tests.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  # config.include Capybara::DSL, type: :feature
  # config.include Rails.application.routes.url_helpers, :type => :feature
  # config.include DeviseRequestSpecHelpers, type: :feature
  # config.include Devise::Test::ControllerHelpers, type: :controller
  # config.include PagesSpecHelper, type: :feature

  config.include FactoryBot::Syntax::Methods
  config.include_context 'request context', type: :request

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
