require 'spec_helper'

module ContentCaching
  describe Configuration do
    let(:configuration) { Configuration.new }

    describe '#adapter' do
      let(:adapter) {{ adapter: :fs, options: { directory: 'tmp' }}}
      it 'the default is fs' do
        expect(configuration.adapter).to eq(adapter)
      end
    end

  end
end
