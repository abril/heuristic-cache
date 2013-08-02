# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'heuristic_cache/version'

Gem::Specification.new do |spec|
  spec.name          = 'heuristic_cache'
  spec.version       = AlxHeuristicCache::VERSION.to_s
  spec.authors       = ['Wilson Souza', 'Luiz Rocha']
  spec.email         = ['willroberto@gmail.com', 'lsdrocha@gmail.com']
  spec.description   = %q{Gem controladora de TTL para recursos}
  spec.summary       = %q{AlxHeuristicCache}
  spec.homepage      = 'https://github.com/abril/heuristic-cache'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'step-up', '0.8.2'
end

