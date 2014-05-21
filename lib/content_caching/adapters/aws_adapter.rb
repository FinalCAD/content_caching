require_relative 'abstract'
require_relative 'implementation'
require_relative 'aws'

module ContentCaching
  module Adapter
    class AwsAdapter < Abstract
      include Implementation

      def adapter
        Aws::new
      end

    end
  end
end
