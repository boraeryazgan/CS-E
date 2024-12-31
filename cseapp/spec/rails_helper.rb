# spec/rails_helper.rb

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support and its subdirectories.
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  # If you're not using ActiveRecord or fixtures, you can remove the next line.
  config.fixture_path = Rails.root.join('spec/fixtures')

  # If you're not using ActiveRecord, or you prefer not to run each test
  # within a transaction, set this to false.
  config.use_transactional_fixtures = true

  # Include the Rails helpers to test controllers, models, and views
  config.include Rails.application.routes.url_helpers
  config.include ActiveJob::TestHelper
end
