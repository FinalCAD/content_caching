require 'rubygems'
require 'bundler/setup'

begin
  require 'pry'
rescue LoadError
end

# require 'right_http_connection'
# require 'webmock'
# require 'webmock/rspec'
# require 'vcr'
#
# VCR.configure do |c|
#   c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
#   c.hook_into :webmock
# end

require_relative '../lib/content_caching'

require 'configatron'

if File.exist?('spec/setting.yml')
  require 'yaml'
  configatron.configure_from_hash(YAML.load_file('spec/setting.yml'))
else
  configatron.directory      = 'bucket-name'
  configatron.api_key_id     = 'api_key_id'
  configatron.api_key_access = 'api_key_access'
end

RSpec.configure do |config|
  config.filter_run focused: true
  config.run_all_when_everything_filtered = true
  # config.before { }
  # config.after  { }
end
