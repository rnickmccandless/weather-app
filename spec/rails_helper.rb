# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'
require 'capybara/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }

# If you are not using ActiveRecord, you can remove these lines.
# begin
#   ActiveRecord::Migration.maintain_test_schema!
# rescue ActiveRecord::PendingMigrationError => e
#   abort e.to_s.strip
# end

Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options:
  )
end

RSpec.configure do |config|
  config.fixture_path = Rails.root.join('spec/fixtures').to_s
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before(:each, type: :system) do
    driven_by :headless_chrome
  end
end
