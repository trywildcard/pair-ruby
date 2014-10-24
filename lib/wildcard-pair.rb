Gem.find_files("wildcard-pair/*.rb").each { |path| require path }
Gem.find_files("wildcard-pair/*/*.rb").each { |path| require path }

module WildcardPair
end