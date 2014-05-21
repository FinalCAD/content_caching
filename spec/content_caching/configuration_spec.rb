require 'spec_helper'

module ContentCaching
  describe Configuration do
    let(:configuration) { Configuration.new }

    describe '#adapter' do
      it 'the default is fs' do
        expect(configuration.adapter).to eq(:fs)
      end
    end

  end
end
