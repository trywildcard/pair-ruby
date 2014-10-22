#!/usr/bin/env ruby -wKU

require 'active_model'
require_relative '../hash_mappable.rb'
require_relative '../Media.rb'

module WildcardPair::Media
  class Image

    include ActiveModel::Validations
    include ActiveModel::Serializers::JSON
    include WildcardPair::HashMappable
    include WildcardPair::Media

    attr_accessor :image_url, :image_caption, :type

    validates :image_url, presence: true
    validates :type, presence: true, inclusion: {in: %w(image), message: 'incorrect media type specified'}

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end

      @type = 'image'
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
        raise "Image is not valid - please remedy the following errors:" << self.errors.messages.to_s
      end    
    end 

  end
end