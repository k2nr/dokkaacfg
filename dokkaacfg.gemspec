# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dokkaacfg/version'

Gem::Specification.new do |spec|
  spec.name          = "dokkaacfg"
  spec.version       = DokkaaCfg::VERSION
  spec.authors       = ["Kazunori Kajihiro"]
  spec.email         = ["likerichie@gmail.com"]
  spec.summary       = %q{Configuration management for Dokkaa cluster}
  spec.homepage      = "https://github.com/k2nr/dokkaacfg"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'barge'
  spec.add_runtime_dependency 'json'
  spec.add_runtime_dependency 'activesupport'
  spec.add_runtime_dependency 'hashr'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'growl'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'foreman'
  spec.add_development_dependency 'webmock'
end
