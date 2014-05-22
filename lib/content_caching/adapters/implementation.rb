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

      def document_name
        @wrapper.document_name
      end

      def document_path
        @wrapper.document_path
      end

    end
  end
end
