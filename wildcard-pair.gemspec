# coding: utf-8
#lib = File.expand_path('/../lib', __FILE__)
#$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
#require 'wildcard-pair/version'

Gem::Specification.new do |spec|
  spec.name          = "wildcard-pair"
  spec.version       = "0.4.5"
  spec.authors       = ["Karthik Senthil"]
  spec.email         = ["partners@trywildcard.com"]
  spec.summary       = "Wildcard Pair Ruby SDK"
  spec.description   = "Wildcard Pair SDK to facilitate partners being able to create cards for their content"
  spec.homepage      = "http://trywildcard.com/dev"
  spec.license       = "MIT"

  spec.files         = Dir['lib/*.rb'] + Dir['lib/*/*.rb'] + Dir['lib/*/*/*.rb']
 # spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
 # spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
 # spec.require_paths = ["lib/wildcard-pair"]

  #spec.add_development_dependency "bundler", "~> 1.6"
  #spec.add_development_dependency "rake"
  #spec.add_development_dependency "rspec"
  spec.add_runtime_dependency "statsd-ruby", '~> 1.2', '>= 1.2.1' 
  spec.add_runtime_dependency "activemodel", '~> 4.1', '>= 4.1.1'
  spec.add_runtime_dependency "nokogiri", '~> 1.6.4', '>= 1.6.4'
end
