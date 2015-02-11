#!/usr/bin/env ruby -wKU

require_relative 'Object.rb'

module WildcardPair  
  class Color < WildcardPair::Object

    attr_accessor :display_name, :swatch_url, :value, :mapping_color

    validates :display_name, presence: true
    validates :mapping_color, allow_nil: true, inclusion: {in: %w(beige black blue bronze brown gold green gray metallic multicolored offwhite orange pink purple red silver transparent turquoise white yellow)}
  end
end