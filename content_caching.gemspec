require_relative 'lib/content_caching/version'

Gem::Specification.new do |spec|
  spec.name          = 'content_caching'
  spec.version       = ContentCaching::VERSION
  spec.authors       = ['Joel AZEMAR']
  spec.email         = ['joel.azemar@gmail.com']
  spec.summary       = %q{Library for help and speed up views render manipulation}
  spec.description   = %q{Library for help and speed up views render manipulation based on aws and local storage}
  spec.homepage      = 'https://github.com/joel/content_caching'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec',   '~> 2.14'

  spec.required_ruby_version = '~> 2.1'
end
