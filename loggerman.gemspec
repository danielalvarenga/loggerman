# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'loggerman/version'

Gem::Specification.new do |spec|
  spec.name          = "loggerman"
  spec.version       = Loggerman::VERSION
  spec.authors       = ["Daniel Alvarenga"]
  spec.email         = ["danielalvarengalima@gmail.com"]

  spec.summary       = %q{Add a custom logger and formatter to rails logs}
  spec.description   = %q{Add a custom logger and formatter to rails logs}
  spec.homepage      = "https://github.com/danielalvarenga/loggerman"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"

  spec.add_runtime_dependency 'activesupport', '>= 4', '< 5.1'
  spec.add_runtime_dependency 'railties',      '>= 4', '< 5.1'
end
