require_relative 'abstract'
require_relative 'implementation'
require_relative 'fs'

module ContentCaching
  module Adapter
    class FsAdapter < Abstract
      include Implementation

      def initialize(wrapper, options)
        super
      end

      def url
        adapter.url document_path, document_name
      end

      def store content
        adapter.store document_path, document_name, content
      end

      def delete
        adapter.delete document_path, document_name
      end

      private

      def document_path
        return @wrapper.document_path unless @options[:directory]
        Pathname([@options[:directory], @wrapper.document_path].join('/')).cleanpath.to_path
      end

      def adapter
        @adapter ||= Fs::new
      end

    end
  end
end
