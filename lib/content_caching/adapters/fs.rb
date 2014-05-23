module ContentCaching
  module Adapter
    class Fs

      def store document_path, content
        Pathname(url(document_path)).write content.read
      end

      def url document_path
        Pathname(document_path).cleanpath.to_path
      end

      def delete document_path
        Pathname(url(document_path)).delete
      end

    end
  end
end
