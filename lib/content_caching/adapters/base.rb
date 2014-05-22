module ContentCaching
  module Adapter
    class Base

      class UnsupportedAdapter < StandardError ; end

      def self.create(adapter_infos, wrapper)
        adapter_type = adapter_infos[:adapter]
        options = adapter_infos[:options]

        load "content_caching/adapters/#{adapter_type}_adapter.rb"
        ContentCaching::Adapter.const_get(klass_adapter(adapter_type)).new(wrapper, options)
      end

      private

      def self.klass_adapter adapter_symbol
        case adapter_symbol
        when :fs then :FsAdapter
        when :aws then :AwsAdapter
        else raise UnsupportedAdapter.new
        end
      end

    end
  end
end
