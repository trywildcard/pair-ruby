#!/usr/bin/env ruby -wKU

require 'active_model'
require_relative 'hash_mappable.rb'
require_relative 'Media.rb'

module WildcardPair
  class Article

    include ActiveModel::Validations
    include ActiveModel::Serializers::JSON
    include WildcardPair::HashMappable
    include WildcardPair::Media

    # required fields
    attr_accessor :title, :html_content
    # optional fields
    attr_accessor :publication_date, :abstract_content, :source, :author,
      :updated_date, :is_breaking, :app_link_android, :app_link_ios

    attr_reader :media

    validates :title, presence: true, length: {minimum: 1}
    validates :html_content, presence: true, length: {minimum: 1}
    validate :validate_media

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def attributes
      instance_values
    end

    def media=(media)
      if media.is_a? Video
        @media = map_hash(media, Media::Video.new)
      else
        @media = map_hash(media, Media::Image.new)
      end
    end

    def validate_media
      if @media.nil? then return end

      if !@media.is_a? Media or !@media.valid?
        errors.add(:media, "Media is invalid")
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
        raise "Article is not valid - please remedy the following errors:" << self.errors.messages.to_s
      end    
    end 

  end
end