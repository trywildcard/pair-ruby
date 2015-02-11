#!/usr/bin/env ruby -wKU

require_relative '../Media.rb'
require_relative '../Object.rb'

module WildcardPair::Media
  class Image < WildcardPair::Object

    include WildcardPair::Media

    attr_accessor :image_url, :image_caption, :type, 
      :title, :author, :width, :height, :publication_date

    validates :image_url, presence: true
    validates :type, presence: true, inclusion: {in: %w(image), message: 'incorrect media type specified'}
    validates :width, allow_nil: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
    validates :height, allow_nil: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}

    def initialize(attributes = {})
      super
      @type = 'image'
    end

    def metatags=(metatags)
      if metatags.nil? || !metatags.is_a?(Hash)
        return
      end

      #see what you can set based on metatags
      self.title=metatags['title']
      self.image_caption=metatags['description']
      self.image_url=metatags['image_url']
    end
  end
end