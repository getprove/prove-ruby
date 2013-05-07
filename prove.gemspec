# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'prove/version'

Gem::Specification.new do |gem|
  gem.name          = "prove"
  gem.version       = Prove::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ["Nick Baugh"]
  gem.email         = ["niftylettuce@gmail.com"]
  gem.homepage      = "https://github.com/getprove/prove-ruby"
  gem.description   = %q{Prove makes it easy to verify phone numbers with voice and SMS.}
  gem.summary       = %q{Phone verification for developers.}
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
