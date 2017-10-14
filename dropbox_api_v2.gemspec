# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dropbox_api_v2/version'

Gem::Specification.new do |spec|
  spec.name          = "dropbox_api_v2"
  spec.version       = DropboxApiV2::VERSION
  spec.authors       = ["smurfik", "Bookis Worthy"]
  spec.email         = ["tammy@mlpinit.com", "bookis.worthy@gmail.com"]

  spec.summary       = %q{Ruby client library for the Dropbox Api V2}
  spec.homepage      = "https://github.com/smurfik/dropbox_api_v2"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.3.0'
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_dependency "curb"
end
