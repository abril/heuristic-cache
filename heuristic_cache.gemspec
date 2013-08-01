# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'heuristic_cache/version'

Gem::Specification.new do |spec|
  spec.name          = "heuristic_cache"
  spec.version       = AlxHeuristicCache::VERSION.to_s
  spec.authors       = ["AbrMidia"]
  spec.email         = ["AgileTeamMusashi@abril.com.br"]
  spec.description   = %q{Gem controladora de TTL para recursos}
  spec.summary       = %q{AlxHeuristicCache}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

end
