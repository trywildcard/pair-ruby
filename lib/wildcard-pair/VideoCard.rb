#!/usr/bin/env ruby -wKU

require 'active_model'
require_relative 'hash_mappable.rb'
require_relative 'Media.rb'

module WildcardPair
  class VideoCard
    private

    attr_accessor :media, :card_type, :pair_version

    public

    include ActiveModel::Validations
    include ActiveModel::Serializers::JSON
    include WildcardPair::HashMappable
    include WildcardPair::Media

    attr_accessor :web_url
    attr_reader :media, :card_type, :pair_version

    validates :web_url, presence: true
    validate :validate_media

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end

      @card_type = 'video'

      if !Gem.loaded_specs['wildcard-pair'].nil?
        @pair_version = Gem.loaded_specs['wildcard-pair'].version.to_s
      else
        @pair_version = "unknown"
      end
    end

    def attributes
      instance_values
    end

    def extract_metatags(web_url)
      @web_url=web_url
      metatags = WildcardPair::ExtractMetaTags.extract(@web_url)

      ##now that we've extracted metatags, let's create a Video object with it
      self.media=WildcardPair::Media::Video.new metatags: metatags
    end

    def media=(media)
      @media = map_hash(media, WildcardPair::Media::Video.new)
    end

    def validate_media
      if @media.nil? || !@media.is_a?(Video)
        errors.add(:media, "A video is required")
        return
      end

      if !@media.valid?
        @media.errors.each do |error, msg|
           errors["media[%s]" % error] = msg = msg
        end
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
        raise "Video Card is not valid - please remedy the following errors:" << self.errors.messages.to_s
      end    
    end 

  end
end

