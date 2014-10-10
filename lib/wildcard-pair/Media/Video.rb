#!/usr/bin/env ruby -wKU

require 'active_model'
require_relative '../hash_mappable.rb'

module WildcardPair::Media
  class Video

    include ActiveModel::Validations
    include ActiveModel::Serializers::JSON
    include WildcardPair::HashMappable
    include WildcardPair::Media

    # required fields
    attr_accessor :title, :embedded_url, :embedded_url_width, :embedded_url_height
    # optional fields
    attr_accessor :stream_url, :stream_content_type, :publication_date, 
      :description, :poster_image_url, :creator, :source, :app_link_ios, 
      :app_link_android

    validates :title, presence: true, length: {minimum: 1}
    validates :embedded_url, presence: true, length: {minimum: 1}
    validates :embedded_url_width, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
    validates :embedded_url_height, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}

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