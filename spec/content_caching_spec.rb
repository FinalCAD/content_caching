require 'spec_helper'

require 'pathname'

module ContentCaching
  describe Document do

    context 'fs' do
      let(:wrapper)         { OpenStruct.new(options) }
      let(:content_caching) { Document.new(wrapper) }

      context 'options' do

        context 'without document path' do
          let(:options) {{ document_name: 'page.html', document_path: nil }}
          specify do
            expect(content_caching.url).to eq('tmp/page.html')
          end
        end

        context 'with document path' do
          let(:options) {{ document_name: 'page.html', document_path: 'pages' }}
          specify do
            expect(content_caching.url).to eq('tmp/pages/page.html')
          end
        end
      end

      describe '#store' do
        let(:options) {{ document_name: 'page.html', document_path: 'public/pages' }}

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

    context 'aws', pending: true do
      let(:wrapper)         { OpenStruct.new(options) }
      let(:options)         {{ document_name: nil, document_path: 'test/page.html' }}
      let(:content_caching) { Document.new(wrapper) }
      let(:adapter) do
        { adapter: :aws,
          options: { directory: 'bucket-name', aws_access_key_id: 'aws_access_key_id',
                     aws_secret_access_key: 'aws_secret_access_key' }
        }
      end

      before do
        ContentCaching.configure do |config|
          config.adapter = adapter
        end
      end

      describe '#url' do

        let(:url) { 'https://bucket-name.s3.amazonaws.com:443/test/page.html' }

        specify do
          expect(content_caching.url).to match(url)
        end
      end

      describe '#store' do
        let(:s3) do
          Aws::S3.new(
            adapter[:options][:aws_access_key_id],
            adapter[:options][:aws_secret_access_key])
        end

        let(:bucket) { Aws::S3::Bucket.new(s3, adapter[:options][:directory]) }

        before do
          # VCR.use_cassette('store') do
            content_caching.store Pathname('spec/fixtures/page.html')
          # end
        end

        specify do
          expect(
            Aws::S3::Key.new(bucket, options[:document_path])
          ).to be_exists
        end

        describe '#delete' do
          before do content_caching.delete end
          specify do
            expect(
              Aws::S3::Key.new(bucket, options[:document_path])
            ).to_not be_exists
          end
        end
      end
    end

  end
end
