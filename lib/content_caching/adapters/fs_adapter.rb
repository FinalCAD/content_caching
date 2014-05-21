require_relative 'abstract'
require_relative 'implementation'
require_relative 'fs'

module ContentCaching
  module Adapter
    class FsAdapter < Abstract
      include Implementation

      def initialize(wrapper)
        super
      end

      def adapter
        Fs::new
      end

      def url
        adapter.url document_path, document_name
      end

    end
  end
end
