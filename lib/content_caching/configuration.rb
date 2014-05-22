module ContentCaching
  class Configuration
    attr_accessor :adapter

    def initialize
      @adapter = { adapter: :fs, options: { directory: 'tmp' }}
    end
  end
end
