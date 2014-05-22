module ContentCaching
  module Adapter
    class Abstract

      def initialize wrapper, options
        @wrapper = wrapper
        @options = options
      end

      def store content
        raise NotImplementedError
      end

      def url
        raise NotImplementedError
      end

      def delete
        raise NotImplementedError
      end

    end
  end
end
