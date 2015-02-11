#!/usr/bin/env ruby -wKU

require_relative 'Card.rb'

module WildcardPair
  class ArticleCard < WildcardPair::Card
    private

    attr_accessor :article

    public

    include WildcardPair::Media

    attr_reader :article

    validate :validate_article

    def initialize(attributes = {})
      super
      @card_type = 'article'
    end

    def populate_from_metatags(web_url)
      @web_url=web_url
      metatags = WildcardPair::ExtractMetaTags.extract(@web_url)

      ##now that we've extracted metatags, let's create a Article 
      self.article=WildcardPair::Article.new metatags: metatags
    end

    def article=(article)
      @article = map_hash(article, WildcardPair::Article.new)
    end

    def validate_article
      if @article.nil? || !@article.is_a?(Article)
        errors.add(:article, "An article is required")
        return
      end

      if !@article.valid?
        @article.errors.each do |error, msg|
           errors["article[%s]" % error] = msg
        end
      end
    end
  end
end

