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
        Retryable.retryable(tries: 3) do
          bucket.put_object(key: document_path,
                            body: content_data(content)
                           )
        end
      end

      def url document_path, expires_at: nil
        bucket.object(document_path).temporary_url expires_at || Time.now + T_1_DAY
      end

      def delete document_path
        Retryable.retryable(tries: 3) do
          bucket.object(document_path).destroy
        end
      end

      private

      def service
        @service ||= ::Aws::S3::Resource.new(
          credentials: aws_credentials,
          region: self.options[:region]
        )
      end

      def bucket
        @bucket ||= service.bucket(self.options[:directory])
      end

      def aws_credentials
        ::Aws::Credentials.new(self.options[:aws_access_key_id],
                               self.options[:aws_secret_access_key])
      end

      def content_data(content)
        content.rewind if content.respond_to?(:rewind)
        if content.respond_to?(:read)
          content.read
        else
          content
        end
      end

    end
  end
end
