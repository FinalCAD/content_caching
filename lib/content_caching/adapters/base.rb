module ContentCaching
  module Adapter
    class Base

      class UnsupportedAdapter < StandardError ; end

      def self.create(adapter, wrapper)
        load "content_caching/adapters/#{adapter}_adapter.rb"
        ContentCaching::Adapter.const_get(klass_adapter(adapter)).new(wrapper)
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
