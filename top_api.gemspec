# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'top_api/version'

Gem::Specification.new do |gem|
  gem.name          = "top_api"
  gem.version       = TopApi::VERSION
  gem.authors       = ["Eric Wong"]
  gem.email         = ["ericsyw@gmail.com"]
  gem.description   = %q{Simple Gem for taobao open platform(TOP) API.}
  gem.summary       = %q{Simple Gem for taobao open platfrom(TOP) API.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_runtime_dependency "json"
end
