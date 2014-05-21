module ContentCaching
  module Adapter
    module Implementation

      def store
        adapter.store
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

      def content
        @wrapper.content
      end

    end
  end
end
