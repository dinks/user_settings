# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'user_settings/version'

Gem::Specification.new do |spec|
  spec.name          = "user_settings"
  spec.version       = UserSettings::VERSION
  spec.authors       = ["Dinesh Vasudevan"]
  spec.email         = ["dinesh.vasudevan@gmail.com"]
  spec.description   = %q{ Stores and Accesses User Settings }
  spec.summary       = %q{ Used to save/remove/update User Settings }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "redis"
  spec.add_runtime_dependency "hiredis"
  spec.add_runtime_dependency "draper", "~> 1.3"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
