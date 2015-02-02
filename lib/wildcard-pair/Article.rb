#!/usr/bin/env ruby -wKU

require_relative 'ObjectWithMedia.rb'

module WildcardPair
  class Article < WildcardPair::ObjectWithMedia

    # required fields
    attr_accessor :title, :html_content
    # optional fields
    attr_accessor :publication_date, :abstract_content, :source, :author,
      :updated_date, :is_breaking, :app_link_android, :app_link_ios

    validates :title, presence: true
    validates :html_content, presence: true

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
  end
end