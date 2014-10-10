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
  spec.homepage      = "https://github.com/dinks/user_settings"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.platform      = Gem::Platform::RUBY
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 1.9.3"

  spec.add_runtime_dependency "redis"
  spec.add_runtime_dependency "hiredis"
  spec.add_runtime_dependency "draper", "~> 1.3"

  spec.add_development_dependency "activesupport", ">= 3.1.0" # For x.months
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "appraisal" # Check against different Rails Versions
  spec.add_development_dependency "capybara" #, "= 2.0.3"
  if RUBY_VERSION > "1.9"
    spec.add_development_dependency "pry-byebug"
  else
    spec.add_development_dependency "pry-debugger"
  end
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "mock_redis"
  spec.add_development_dependency "coveralls"
end
