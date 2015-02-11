#!/usr/bin/env ruby -wKU

require_relative 'Object.rb'

module WildcardPair
  class Rating < WildcardPair::Object

    # required fields
    attr_accessor :rating, :minimum_rating, :maximum_rating
    # optional fields
    attr_accessor :number_of_ratings

    validates :rating, presence: true, numericality: {greater_than_or_equal_to: 0}
    validates :minimum_rating, presence: true, numericality: {greater_than_or_equal_to: 0}
    validates :maximum_rating, presence: true, numericality: {greater_than_or_equal_to: 0}
    validates :number_of_ratings, allow_nil: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  end
end