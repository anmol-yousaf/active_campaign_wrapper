# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  add_filter 'spec/'
  add_filter '.github/'
  add_filter 'lib/generators/templates/'
end

require 'dotenv/load'
require 'bundler/setup'
require 'pry'
require 'rspec'
require 'rspec/json_expectations'
require 'active_campaign_wrapper'

RSpec.configure do |config|
  config.define_derived_metadata do |meta|
    meta[:aggregate_failures] = true
  end
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.example_status_persistence_file_path = '.rspec_status'
  config.filter_run :focus unless ENV['CI']
  config.run_all_when_everything_filtered = true
  config.disable_monkey_patching!
  config.warnings = false
  config.default_formatter = 'doc' if config.files_to_run.one?
  config.order = :random

  Kernel.srand config.seed
end

ActiveCampaignWrapper.config do |config|
  config.endpoint_url = ENV['ACTIVE_CAMPAIGN_API_HOST']
  config.api_token = ENV['ACTIVE_CAMPAIGN_API_KEY']
end

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f }
