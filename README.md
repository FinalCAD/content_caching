# ContentCaching

[![Gem Version](https://badge.fury.io/rb/content_caching.svg)](http://badge.fury.io/rb/content_caching)
[![Code Climate](https://codeclimate.com/github/FinalCAD/content_caching.png)](https://codeclimate.com/github/FinalCAD/content_caching)
[![Dependency Status](https://gemnasium.com/FinalCAD/content_caching.png)](https://gemnasium.com/FinalCAD/content_caching)
[![Build Status](https://travis-ci.org/FinalCAD/content_caching.svg?branch=master)](https://travis-ci.org/FinalCAD/content_caching)
[![Coverage Status](https://coveralls.io/repos/FinalCAD/content_caching/badge.png)](https://coveralls.io/r/FinalCAD/content_caching)

## Installation

Add this line to your application's Gemfile:

```
    gem 'content_caching'
```

And then execute:

```
    $ bundle
```

Or install it yourself as:

```
    $ gem install content_caching
```

## Usage

You can configure content_caching for playing with local storage or aws s3

By befault content_caching provide filesystem configuration like that

```
    { adapter: :fs, options: { directory: 'tmp' }}
```

is pretty basic, but you can change these configuration

fs sample

```
    ContentCaching.configure do |config|
      config.adapter = { adapter: :fs, options: { directory: 'public/htmls' }}
    end
```

AWS s3 sample

```
    ContentCaching.configure do |config|
      config.adapter = { adapter: :aws,
              options: { directory: directory, aws_access_key_id: api_key_id,
                         aws_secret_access_key: api_key_access }}
    end
```

for s3 you need provide extra information, bucket name, api key and secret

ContentCaching implement the following interface

```
    Query
      .url()

    Command
      .store()
      .delete()
```

When you initialize an Document you need pass an object who respond to .to_path() contract. content_caching provide an Wrapper for help you.

```
    wrapper = ContentCaching::Wrapper.new('path of your document')
    content_caching = ContentCaching::Document.new(wrapper)
```

You can store any content when you pass an Object respond to .read() contract to method .store()

```
    content_caching.store StringIO.new('foo')
```

You can ask for full path

```
    content_caching.url
```

And you can delete file

```
    content_caching.delete
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/content_caching/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
