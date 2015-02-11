#!/usr/bin/env ruby -wKU

require_relative '../Media.rb'
require_relative '../Object.rb'

module WildcardPair::Media
  class Video < WildcardPair::Object

    include WildcardPair::Media

    # required fields
    attr_accessor :title, :embedded_url, :embedded_url_width, :embedded_url_height, :type
    # optional fields
    attr_accessor :stream_url, :stream_content_type, :publication_date, 
      :description, :poster_image_url, :creator, :source, :app_link_ios, 
      :app_link_android

    validates :title, presence: true
    validates :embedded_url, presence: true
    validates :embedded_url_width, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
    validates :embedded_url_height, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
    validates :type, presence: true, inclusion: {in: %w(video), message: 'incorrect media type specified'}

    def initialize(attributes = {})
      super
      @type = 'video'
    end

    def metatags=(metatags)
      if metatags.nil? || !metatags.is_a?(Hash)
        return
      end

      #see what you can set based on metatags
      self.title=metatags['title']
      self.embedded_url=metatags['video_url']
      self.embedded_url_height=metatags['video_height']
      self.embedded_url_width=metatags['video_width']

      self.description=metatags['description']
      self.poster_image_url=metatags['image_url']
      self.app_link_ios=metatags['applink_ios']
      self.app_link_android=metatags['applink_android']
    end
  end
end