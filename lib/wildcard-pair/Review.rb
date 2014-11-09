#!/usr/bin/env ruby -wKU

require 'active_model'
require_relative 'hash_mappable.rb'
require_relative 'Media.rb'

module WildcardPair
  class Review

    include ActiveModel::Validations
    include ActiveModel::Serializers::JSON
    include WildcardPair::HashMappable
    include WildcardPair::Media

    # required fields
    attr_accessor :title, :html_content
    # optional fields
    attr_accessor :publication_date, :abstract_content, :source, :author,
      :updated_date, :product_name, :app_link_ios,
      :app_link_android
    attr_reader :rating, :media

    validates :title, presence: true
    validates :html_content, presence: true

    validate :validate_media
    validate :validate_rating

    def metatags=(metatags)
      if metatags.nil? || !metatags.is_a?(Hash)
        return
      end

      #see what you can set based on metatags
      self.title=metatags['title']
      self.html_content=metatags['html']
      self.abstract_content=metatags['description']
      self.media=Media::Image.new image_url: metatags['image_url']
      self.app_link_ios=metatags['applink_ios']
      self.app_link_android=metatags['applink_android']
    end

    def media=(media)
      if media.is_a? Video
        @media = map_hash(media, Media::Video.new)
      elsif media.is_a? Image
        @media = map_hash(media, Media::Image.new)
      elsif media.is_a? Hash
        if media[:type] == 'video'
          @media = map_hash(media, Media::Video.new)
        elsif media[:type] == 'image'
          @media = map_hash(media, Media::Image.new)
        else
          @media = media
        end
      end
    end

    def validate_media
      if @media.nil? then return end

      if !@media.is_a? Media or !@media.valid?
        errors.add(:media, "Media is invalid")
        return false
      end
    end

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