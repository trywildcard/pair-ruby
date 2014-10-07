# coding: utf-8
#lib = File.expand_path('/../lib', __FILE__)
#$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
#require 'wildcard-pair/version'

Gem::Specification.new do |spec|
  spec.name          = "wildcard-pair"
  spec.version       = "0.1.2"
  spec.authors       = ["Karthik Senthil"]
  spec.email         = ["pair@trywildcard.com"]
  spec.summary       = "Wildcard Pair Ruby SDK"
  spec.description   = "Wildcard Pair SDK to faciliate partners create card content"
  spec.homepage      = "http://pair.trywildcard.com"
  spec.license       = "MIT"

  spec.files         = ["lib/wildcard-pair.rb", "lib/wildcard-pair/Color.rb", "lib/wildcard-pair/Offer.rb", "lib/wildcard-pair/Product.rb", "lib/wildcard-pair/ProductCard.rb", "lib/wildcard-pair/ProductSearchCard.rb", "lib/wildcard-pair/ProductSearchResult.rb", "lib/wildcard-pair/Price.rb", "lib/wildcard-pair/hash_mappable.rb"]
 # spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
 # spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
 # spec.require_paths = ["lib/wildcard-pair"]

  #spec.add_development_dependency "bundler", "~> 1.6"
  #spec.add_development_dependency "rake"
  #spec.add_development_dependency "rspec"
  spec.add_runtime_dependency "statsd-ruby", '~> 1.2', '>= 1.2.1' 
  spec.add_runtime_dependency "activemodel", '~> 4.1', '>= 4.1.1'
end
