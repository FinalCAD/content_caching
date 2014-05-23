require_relative 'content_caching/version'
require_relative 'content_caching/configuration'
require_relative 'content_caching/wrapper'
require_relative 'content_caching/adapters/base'

begin
  require 'pry'
rescue LoadError
end

require 'forwardable'

module ContentCaching
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  class Document
    extend Forwardable

    def_delegators :adapter, :store, :url, :delete
    attr_accessor :adapter

    def initialize wrapper
      self.adapter = ContentCaching::Adapter::Base.create(ContentCaching.configuration.adapter, wrapper)
    end
  end
end
