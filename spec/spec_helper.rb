require 'rubygems'
require 'bundler/setup'

begin
  require 'pry'
rescue LoadError
end

require_relative '../lib/content_caching'

RSpec.configure do |config|
  config.filter_run focused: true
  config.run_all_when_everything_filtered = true
  # config.before { }
  # config.after  { }
end
