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

      def url(expires_in: nil)
        adapter.url document_path, expires_in: expires_in
      end

      def store content, type
        adapter.store document_path, content, type
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
