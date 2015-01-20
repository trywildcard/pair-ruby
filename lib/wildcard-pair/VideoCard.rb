#!/usr/bin/env ruby -wKU

require_relative 'Card.rb'
require_relative 'Media.rb'

module WildcardPair
  class VideoCard < WildcardPair::Card
    private

    attr_accessor :media

    public

    include WildcardPair::Media

    attr_reader :media

    validate :validate_media

    def initialize(attributes = {})
      super
      @card_type = 'video'
    end

    def populate_from_metatags(web_url)
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

  end
end

