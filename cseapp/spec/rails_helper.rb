# spec/rails_helper.rb

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

# Uncomment the line below if you have `--require rails_helper` in the `.rspec` file
# to avoid Rails generators crashing due to pending migrations
# return unless Rails.env.test?

require 'rspec/rails'

# Additional requires below this line. Rails is loaded after this point.

# Automatically require supporting ruby files with custom matchers and macros in spec/support/
# It is recommended not to name files in spec/support with _spec.rb to avoid running specs twice.
# Rails.root.glob('spec/support/**/*.rb').sort_by(&:to_s).each { |f| require f }

# Ensure migrations are applied before running tests
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  # Fixture path, remove if you're not using fixtures
  config.fixture_path = Rails.root.join('spec/fixtures')

  # Use transactional fixtures to wrap each test in a transaction
  config.use_transactional_fixtures = true

  # Uncomment if you're not using ActiveRecord
  # config.use_active_record = false

  # Automatically infer test type based on location (e.g., /spec/models => type: :model)
  config.infer
