require 'fileutils'

module ContentCaching
  module Adapter
    class Fs

      def store document_path, content
        content.rewind if content.respond_to?(:rewind)
        create_directory_for(document_path)
        File.write url(document_path), content.respond_to?(:read) ? content.read : content
      end

      def url document_url
        document_url
      end

      def delete document_path
        File.delete url(document_path)
      end

      private

      def create_directory_for(document_path)
        dir = File.dirname(document_path)
        unless File.directory?(dir)
          FileUtils.mkdir_p(dir)
        end
      end
    end
  end
end
