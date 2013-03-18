# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_arel/version'

Gem::Specification.new do |spec|
  spec.name          = "simple-arel-rails"
  spec.version       = SimpleArel::VERSION
  spec.authors       = ["John Kamenik"]
  spec.email         = ["jkamenik@gmail.com"]
  spec.description   = %q{A complete ripoff of RailsCast #355}
  spec.summary       = %q{Simple Arel for Rails}
  spec.homepage      = "https://github.com/jkamenik/simple-arel-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activerecord', '~> 3.0'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'sqlite3', '~> 1.3.3'
end
