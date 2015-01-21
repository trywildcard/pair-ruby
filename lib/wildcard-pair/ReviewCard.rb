#!/usr/bin/env ruby -wKU

require_relative 'Card.rb'

module WildcardPair
  class ReviewCard < WildcardPair::Card
    private

    attr_accessor :review

    public

    attr_reader :review

    validate :validate_review

    def initialize(attributes = {})
      super
      @card_type = 'review'
    end

    def populate_from_metatags(web_url)
      @web_url=web_url
      metatags = WildcardPair::ExtractMetaTags.extract(@web_url)

      ##now that we've extracted metatags, let's create a Review 
      self.review=WildcardPair::Review.new metatags: metatags
      self.app_link_ios=metatags['applink_ios']
      self.app_link_android=metatags['applink_android']
    end

    def review=(review)
      @review = map_hash(review, WildcardPair::Review.new)
    end

    def validate_review
      if @review.nil? or !@review.is_a? Review
        errors.add(:review, "A review is required")
        return
      end

      if !@review.valid?
        @review.errors.each do |error, msg|
           errors["review[%s]" % error] = msg
        end
      end
    end

  end
end

