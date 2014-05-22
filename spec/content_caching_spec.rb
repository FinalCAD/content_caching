require 'spec_helper'

require 'pathname'

module ContentCaching
  describe Document do
    let(:wrapper) do
      OpenStruct.new document_name: 'page.html', document_path: 'foo/pages'
    end
    let(:content_caching) { Document.new(wrapper) }

    describe '#url' do
      specify do
        expect(content_caching.url).to eq('foo/pages/page.html')
      end
    end

    describe '#store' do
      let(:wrapper) do
        OpenStruct.new document_name: 'page.html', document_path: 'tmp/public/pages'
      end
      before do
        content_caching.store Pathname('spec/fixtures/page.html')
      end
      specify do
        expect(Pathname('tmp/public/pages/page.html')).to be_exist
      end
      
      describe '#delete' do
        before do content_caching.delete end
        specify do
          expect(Pathname('tmp/public/pages/page.html')).to_not be_exist
        end
      end
    end

  end
end
