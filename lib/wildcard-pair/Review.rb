#!/usr/bin/env ruby -wKU

require_relative 'ObjectWithMedia.rb'

module WildcardPair
  class Review < WildcardPair::ObjectWithMedia

    # required fields
    attr_accessor :title, :html_content
    # optional fields
    attr_accessor :publication_date, :abstract_content, :source, :author,
      :updated_date, :product_name, :app_link_ios,
      :app_link_android
    attr_reader :rating, :media

    validates :title, presence: true
    validates :html_content, presence: true

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

    def rating=(rating)
      @rating = map_hash(rating, WildcardPair::Rating.new)
    end

    def validate_rating
      if @rating.nil? then return end

      if !@rating.is_a? Rating or !@rating.valid?
        errors.add(:rating, "Rating is invalid")
        return false
      end
    end
  end
end