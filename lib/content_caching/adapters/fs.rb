module ContentCaching
  module Adapter
    class Fs

      def store
      end

      def url document_path, document_name
        "#{document_path}/#{document_name}"
      end

      def delete
      end

    end
  end
end
