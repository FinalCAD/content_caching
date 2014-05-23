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
        adapter.url document_path
      end

      def store content
        adapter.store document_path, content
      end

      def delete
        adapter.delete document_path
      end

      private

      def document_path
        return @wrapper.to_path unless @options[:directory]
        Pathname([@options[:directory], @wrapper.to_path].join('/')).cleanpath.to_path
      end

      def adapter
        @adapter ||= Fs::new
      end

    end
  end
end
