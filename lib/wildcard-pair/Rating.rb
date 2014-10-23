#!/usr/bin/env ruby -wKU

require 'active_model'
require_relative 'hash_mappable.rb'

module WildcardPair
  class Rating

    include ActiveModel::Validations
    include ActiveModel::Serializers::JSON
    include WildcardPair::HashMappable

    # required fields
    attr_accessor :rating, :minimum_rating, :maximum_rating
    # optional fields
    attr_accessor :number_of_ratings

    validates :rating, presence: true, numericality: {greater_than_or_equal_to: 0}
    validates :minimum_rating, presence: true, numericality: {greater_than_or_equal_to: 0}
    validates :maximum_rating, presence: true, numericality: {greater_than_or_equal_to: 0}
    validates :number_of_ratings, allow_nil: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def attributes
      instance_values
    end

    #exclude validation fields in the JSON output
    def as_json(options={})
      super(options.merge({:except => [:errors, :validation_context]}))
    end

    def to_json(options={})
      if self.valid?
        super(options)
      else
        raise "Video is not valid - please remedy the following errors:" << self.errors.messages.to_s
      end    
    end 

  end
end