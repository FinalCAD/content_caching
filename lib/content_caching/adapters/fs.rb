module ContentCaching
  module Adapter
    class Fs

      def store document_path, content
        content.rewind if content.respond_to?(:rewind)
        Pathname(url(document_path)).write content.respond_to?(:read) ? content.read : content
      end

      def url document_url
        document_url
      end

      def delete document_path
        Pathname(url(document_path)).delete
      end

    end
  end
end
