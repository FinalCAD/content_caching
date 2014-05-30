require 'spec_helper'

module ContentCaching
  describe Configuration do
    let(:configuration) { Configuration.new }

    describe '#adapter' do
      let(:adapter) {{ adapter: :fs, options: { host: 'http://0.0.0.0:3000', directory: 'tmp' }}}
      it 'the default is fs' do
        expect(configuration.adapter).to eq(adapter)
      end
    end

  end
end
