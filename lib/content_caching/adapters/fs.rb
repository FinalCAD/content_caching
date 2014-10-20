module ContentCaching
  module Adapter
    class Fs

      def store document_path, content
        content.rewind if content.respond_to?(:rewind)
        File.write url(document_path), content.respond_to?(:read) ? content.read : content
      end

      def url document_url
        document_url
      end

      def delete document_path
        File.delete url(document_path)
      end

    end
  end
end
