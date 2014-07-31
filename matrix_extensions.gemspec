# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'matrix_extensions/version'

Gem::Specification.new do |spec|
  spec.name          = "matrix_extensions"
  spec.version       = MatrixExtensions::VERSION
  spec.authors       = ["Michael Imstepf"]
  spec.email         = ["michael.imstepf@gmail.com"]
  spec.summary       = %q{Extension of the Ruby Matrix class.}
  spec.description   = %q{Element-wise matrix operations, concatenation and pre-filled matrices with single values.}
  spec.homepage      = "https://github.com/michaelimstepf/matrix-extensions"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
