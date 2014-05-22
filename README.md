# ContentCaching

[![Gem Version](https://badge.fury.io/rb/content_caching.svg)](http://badge.fury.io/rb/content_caching)
[![Code Climate](https://codeclimate.com/github/joel/content_caching.png)](https://codeclimate.com/github/joel/content_caching)
[![Dependency Status](https://gemnasium.com/joel/content_caching.png)](https://gemnasium.com/joel/content_caching)
[![Build Status](https://travis-ci.org/joel/content_caching.svg?branch=master)](https://travis-ci.org/joel/content_caching)
[![Coverage Status](https://coveralls.io/repos/joel/content_caching/badge.png)](https://coveralls.io/r/joel/content_caching)

## Installation

Add this line to your application's Gemfile:

    gem 'content_caching'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install content_caching

## Usage

    ContentCaching.configure do |config|
      config.adapter = { adapter: :fs, options: { directory: 'public/htmls' }}
    end

    class Wrapper < Struct.new(:document_name, :document_path)
    end

    content_caching = ContentCaching.new(wrapper)
    content_caching.store StringIO.new('foo')
    content_caching.url
    content_caching.delete

    You can store independently on local storage or s3

## Contributing

1. Fork it ( https://github.com/[my-github-username]/content_caching/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
