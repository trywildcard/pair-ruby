#!/usr/bin/env ruby -wKU

require_relative 'Card.rb'

module WildcardPair
  class ImageCard < WildcardPair::Card
    private

    attr_accessor :media

    public

    include WildcardPair::Media

    attr_reader :media

    validate :validate_media

    def initialize(attributes = {})
      super
      @card_type = 'image'
    end

    def populate_from_metatags(web_url)
      @web_url=web_url
      metatags = WildcardPair::ExtractMetaTags.extract(@web_url)

      ##now that we've extracted metatags, let's create an Image object with it
      self.media=WildcardPair::Media::Image.new metatags: metatags
      self.app_link_ios = metatags['applink_ios']
      self.app_link_android = metatags['applink_android']
    end

    def media=(media)
      @media = map_hash(media, WildcardPair::Media::Image.new)
    end

    def validate_media
      if @media.nil? || !@media.is_a?(Image)
        errors.add(:media, "An image is required")
        return
      end

      if !@media.valid?
        @media.errors.each do |error, msg|
           errors["media[%s]" % error] = msg = msg
        end
      end
    end

  end
end