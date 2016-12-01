# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

Capybara.default_max_wait_time = 5