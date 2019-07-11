# frozen_string_literal: true

require 'simplecov'
require 'coveralls'
Coveralls.wear!('rails')

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [
    Coveralls::SimpleCov::Formatter,
    SimpleCov::Formatter::HTMLFormatter
  ]
)

SimpleCov.start do
  add_filter 'lib/ledger_sync/util/debug.rb'
end

require 'bundler/setup'
require 'ap'
require 'byebug'
require 'ledger_sync'

# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.example_status_persistence_file_path = 'tmp/rspec_history.txt'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def support(path)
  require File.join(LedgerSync.root, 'spec/support/', path.to_s)
end
