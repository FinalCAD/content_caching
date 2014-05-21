module ContentCaching
  class Configuration
    attr_accessor :adapter

    def initialize
      @adapter = :fs
    end
  end
end
