require 'spec_helper'


module ContentCaching
  describe Document do
    let(:wrapper) do
      OpenStruct.new document_name: 'page.html', document_path: '/public/pages'
    end
    let(:content_caching) { Document.new(wrapper) }

    describe '#url' do
      specify do
        expect(content_caching.url).to eq('/public/pages/page.html')
      end
    end
  end
end
