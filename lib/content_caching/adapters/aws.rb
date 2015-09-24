require 'aws-sdk-resources' # This lib is accessible through ::Aws...

module ContentCaching
  module Adapter
    class Aws
      include RetryableBlock

      T_1_DAY = 86400.freeze

      attr_reader :options

      def initialize options
        @options = options
      end

      def store document_path, content
        retryable(3) do
          content.rewind if content.respond_to?(:rewind)
          bucket.put_object key: document_path,
            body: (content.respond_to?(:read) ? content.read : content)
        end
      end

      def url document_path
        bucket.object(document_path).presigned_url :get, expires_in: T_1_DAY
      end

      def delete document_path
        retryable(3) do
          bucket.object(document_path).delete
        end
      end

      private

      def bucket
        ::Aws::S3::Resource.new(
          credentials: aws_credentials,
          region: self.options[:region]
        ).bucket self.options[:directory]
      end

      def aws_credentials
       :: Aws::Credentials.new self.options[:aws_access_key_id],
                             self.options[:aws_secret_access_key]
      end
    end
  end
end
