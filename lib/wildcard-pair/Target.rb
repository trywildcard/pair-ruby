#!/usr/bin/env ruby -wKU

require_relative 'Object.rb'

module WildcardPair  
  class Target < WildcardPair::Object

    attr_accessor :url, :title, :description, :publication_date

    validates :url, presence: true
  end
end