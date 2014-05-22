module ContentCaching
  module Adapter
    class Fs

      def store document_path, document_name, content
        Pathname(url(document_path, document_name)).write content.read
      end

      def url document_path, document_name
        "#{document_path}/#{document_name}"
      end

      def delete document_path, document_name
        Pathname(url(document_path, document_name)).delete
      end

    end
  end
end
