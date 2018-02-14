require 's3'
require 'retryable_block'

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
          new_object = bucket.objects.build document_path
          new_object.content = content
          new_object.save
        end
      end

      def url document_path, expires_at: nil
        bucket.object(document_path).temporary_url expires_at || Time.now + T_1_DAY
      end

      def delete document_path
        retryable(3) do
          bucket.object(document_path).destroy
        end
      end

      private

      def service
        @service ||= S3::Service.new(
          :access_key_id => self.options[:aws_access_key_id],
          :secret_access_key => self.options[:aws_secret_access_key],
          :use_ssl => true,
          :use_vhost => true
        )
      end

      def bucket
        @bucket ||= service.bucket(self.options[:directory])
      end
    end
  end
end
