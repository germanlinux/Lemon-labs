# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cargo_batch/version'

Gem::Specification.new do |spec|
  spec.name          = "cargo_batch"
  spec.version       = CargoBatch::VERSION
  spec.authors       = ["Eric GERMAN"]
  spec.email         = ["german.eric@gmail.com"]
  spec.description   = %q{batch framework like spring batch}
  spec.summary       = %q{batch framework}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
