require 'aws'

module ContentCaching
  module Adapter
    class Aws

      T_1_DAY = 86400.freeze

      attr_reader :options

      def initialize options
        @options = options
      end

      def store document_path, content
        retry_3_times do
          content.rewind if content.respond_to?(:rewind)
          s3_interface.put self.options[:directory], document_path, content.read
        end
      end

      def url document_path
        s3_interface.get_link self.options[:directory], document_path, T_1_DAY
      end

      def delete document_path
        retry_3_times do
          s3_interface.delete self.options[:directory], document_path
        end
      end

      private

      def s3_interface
        @s3_interface ||= ::Aws::S3Interface.new self.options[:aws_access_key_id],
                                                 self.options[:aws_secret_access_key]
      end

      def retry_3_times
        tries = 0
        begin
          yield
        rescue
          (tries += 1) <3 ? retry : raise
        end
      end

    end
  end
end
