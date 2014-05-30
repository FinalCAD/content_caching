module ContentCaching
  class Configuration
    attr_accessor :adapter

    def initialize
      @adapter = { adapter: :fs, options: { host: 'http://0.0.0.0:3000', directory: 'tmp' }}
    end
  end
end
