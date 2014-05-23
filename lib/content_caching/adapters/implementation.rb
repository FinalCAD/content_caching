module ContentCaching
  module Adapter
    module Implementation

      def store content
        adapter.store content
      end

      def url
        adapter.url
      end

      def delete
        adapter.delete
      end

      private

      def document_path
        @wrapper.to_path
      end

    end
  end
end
