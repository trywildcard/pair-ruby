#!/usr/bin/env ruby -wKU

require 'active_model'
require_relative 'hash_mappable.rb'

module WildcardPair
  class Review

    include ActiveModel::Validations
    include ActiveModel::Serializers::JSON
    include WildcardPair::HashMappable

    # required fields
    attr_accessor :title, :html_content
    # optional fields
    attr_accessor :publication_date, :abstract_content, :source, :author,
      :updated_date, :media, :product_name, :app_link_ios,
      :app_link_android
    attr_reader :rating

    validates :title, presence: true, length: {minimum: 1}
    validates :html_content, presence: true, length: {minimum: 1}

    validate :validate_rating

    def rating=(rating)
      @rating = map_hash(rating, WildcardPair::Rating.new)
    end

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def attributes
      instance_values
    end

    def validate_rating
      if @rating.nil? then return end

      if !@rating.is_a? Rating or !@rating.valid?
        errors.add(:rating, "Rating is invalid")
        return false
      end
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