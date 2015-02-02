#!/usr/bin/env ruby -wKU

require_relative 'ObjectWithMedia.rb'

module WildcardPair  
  class Summary < WildcardPair::ObjectWithMedia

    attr_accessor :title, :description

    validates :title, presence: true
    validates :description, presence: true
  end
end