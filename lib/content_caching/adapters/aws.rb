require 'aws-sdk-s3'

module ContentCaching
  module Adapter
    class Aws
      T_1_DAY = 86400.freeze

      attr_reader :options

      def initialize options
        @options = options
      end

      def store document_path, content
        ::Retryable.retryable(tries: 3) do
          bucket.put_object(key: document_path, body: content)
        end
      end

      def url document_path, expires_in: nil
        bucket.object(document_path).presigned_url :get, expires_in: expires_in || T_1_DAY
      end

      def delete document_path
        Retryable.retryable(tries: 3) do
          bucket.object(document_path).delete
        end
      end

      private

      def service
        @service ||= ::Aws::S3::Resource.new(
          credentials: aws_credentials,
          region: self.options[:aws_region]
        )
      end

      def bucket
        @bucket ||= service.bucket(self.options[:directory])
      end

      def aws_credentials
        ::Aws::Credentials.new(self.options[:aws_access_key_id],
                               self.options[:aws_secret_access_key])
      end
    end
  end
end
