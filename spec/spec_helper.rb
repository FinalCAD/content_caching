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

RSpec.configure do |config|
  config.filter_run focused: true
  config.run_all_when_everything_filtered = true
  # config.before { }
  # config.after  { }
end
