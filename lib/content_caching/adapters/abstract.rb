module ContentCaching
  module Adapter
    class Abstract

      def initialize wrapper
        @wrapper = wrapper
      end

      def store
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
