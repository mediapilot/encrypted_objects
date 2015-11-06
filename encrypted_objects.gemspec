# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'encrypted_objects/version'

Gem::Specification.new do |spec|
  spec.name          = "encrypted_objects"
  spec.version       = EncryptedObjects::VERSION
  spec.authors       = ["sauy7"]
  spec.email         = ["tim@heighes.com"]

  spec.summary       = %q{Utility gem for encoding/decoding Ruby objects using Base64 from the standard library}
  spec.homepage      = "https://github.com/sauy7/encryted_objects"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "multi_json", '~> 1.0'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
