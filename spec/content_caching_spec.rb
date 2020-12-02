require 'spec_helper'

require 'pathname'
# require 'configatron'

module ContentCaching
  describe Document do
    let(:wrapper)         { Wrapper.new(path) }
    let(:content_caching) { Document.new(wrapper) }

    context 'fs' do
      context 'without document path' do
        let(:path) { 'page.html' }
        specify do
          expect(content_caching.url).to eq('http://0.0.0.0:3000/page.html')
        end
      end

      describe '#store' do
        let(:path) { 'public/pages/page.html' }

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

      context "when directory doesn't exist" do
        let(:path) { 'public/pages/custom-directory/page.html' }

        before { FileUtils.rm_rf 'tmp/public/pages/custom-directory' }
        after { FileUtils.rm_rf 'tmp/public/pages/custom-directory' }

        it "creates missing directory" do
          content_caching.store Pathname('spec/fixtures/page.html')
          expect(Pathname('tmp/public/pages/custom-directory/page.html')).to be_exist
        end
      end
    end

    context 'aws', pending: true do
      let(:path)            { 'test/page.html' }
      let(:adapter) do
        { adapter: :aws,
          options: { directory: directory, aws_access_key_id: api_key_id,
                     aws_secret_access_key: api_key_access }
        }
      end
      let(:directory)      { configatron.directory }
      let(:api_key_id)     { configatron.api_key_id }
      let(:api_key_access) { configatron.api_key_access }

      before do
        ContentCaching.configure do |config|
          config.adapter = adapter
        end
      end

      describe '#url' do

        let(:url) { "https://#{directory}.s3.amazonaws.com:443/test/page.html" }

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
            content_caching.store Pathname('spec/fixtures/page.html'), :html
          # end
        end

        specify do
          expect(
            Aws::S3::Key.new(bucket, path)
          ).to be_exists
        end

        describe '#delete' do
          before do content_caching.delete end
          specify do
            expect(
              Aws::S3::Key.new(bucket, path)
            ).to_not be_exists
          end
        end
      end
    end
  end
end
