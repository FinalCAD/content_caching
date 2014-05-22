require_relative 'abstract'
require_relative 'implementation'
require_relative 'aws'

module ContentCaching
  module Adapter
    class AwsAdapter < Abstract
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

      def adapter
        @adapter ||= Aws::new(@options)
      end

    end
  end
end
