# -*- encoding: utf-8 -*-
require File.expand_path("../lib/present_foo/version", __FILE__)

Gem::Specification.new do |gem|

  gem.authors       = ["JC Grubbs"]
  gem.email         = ["jc.grubbs@devmynd.com"]
  gem.summary       = %q{Very simple presenters for Rails applications.}
  gem.homepage      = "https://github.com/devmynd/present_foo"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "present_foo"
  gem.require_paths = ["lib"]
  gem.version       = PresentFoo::VERSION

  gem.add_development_dependency "rails", "~> 3.2.0"
  gem.add_development_dependency "rspec", "~> 2.9.0"
  gem.add_development_dependency "rspec-rails", "~> 2.9.0"
  gem.add_development_dependency "debugger", "1.1.1"

end
