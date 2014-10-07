
require 'active_model'
require_relative 'hash_mappable.rb'

module WildcardPair  
  class Color
    include ActiveModel::Validations
    include ActiveModel::Serializers::JSON
    include WildcardPair::HashMappable

    attr_accessor :display_name, :swatch_url, :value, :mapping_color

    validates :mapping_color, allow_nil: true, inclusion: {in: %w(beige black blue bronze brown gold green gray metallic multicolored offwhite orange pink purple red silver transparent turquoise white yellow)}
 
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


    def to_json(options = {})
      if self.valid?
        super(options)
      else
        raise "Color is not valid - please remedy the following errors:" << self.errors.messages.to_s
      end   
    end 

  end
end