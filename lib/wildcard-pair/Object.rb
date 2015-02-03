#!/usr/bin/env ruby -wKU

require 'active_model'
require_relative 'hash_mappable.rb'

module WildcardPair  
  class Object
    include ActiveModel::Validations
    include ActiveModel::Serializers::JSON
    include WildcardPair::HashMappable

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
        raise self.class.to_s + " is not valid - please remedy the following errors:" << self.errors.messages.to_s
      end    
    end 
  end
end