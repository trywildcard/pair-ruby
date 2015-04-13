require 'wildcard-pair/Card.rb'
require 'wildcard-pair/Media.rb'
require 'wildcard-pair/Media/Image.rb'
require 'wildcard-pair/Media/Video.rb'
require 'wildcard-pair/Object.rb'

Gem.find_files("wildcard-pair/*.rb").each { |path| require path }
Gem.find_files("wildcard-pair/*/*.rb").each { |path| require path }

module WildcardPair
end