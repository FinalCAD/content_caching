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
        return @wrapper.document_path unless @options[:directory]
        Pathname([@options[:directory], @wrapper.document_path].join('/')).cleanpath.to_path
      end

    end
  end
end
