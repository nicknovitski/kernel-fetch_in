# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fetch_in/version'

Gem::Specification.new do |spec|
  spec.name          = 'kernel-fetch_in'
  spec.version       = FetchIn::VERSION
  spec.authors       = ['Nick Novitski']
  spec.email         = ['nicknovitski@gmail.com']
  spec.summary       = 'Nested #fetch in functional and OO flavors'
  spec.homepage      = 'https://github.com/nicknovitski/kernel-fetch_in'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(/^spec\//)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.1'
end
