#!/usr/bin/env ruby -wKU

require 'active_model'
require_relative 'hash_mappable.rb'
require_relative 'Media.rb'

module WildcardPair
  class ArticleCard
    private

    attr_accessor :article, :card_type, :pair_version

    public

    include ActiveModel::Validations
    include ActiveModel::Serializers::JSON
    include WildcardPair::HashMappable
    include WildcardPair::Media

    attr_accessor :web_url
    attr_reader :article, :card_type, :pair_version

    validates :web_url, presence: true
    validate :validate_article

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end

      @card_type = 'article'

      if !Gem.loaded_specs['wildcard-pair'].nil?
        @pair_version = Gem.loaded_specs['wildcard-pair'].version.to_s
      else
        @pair_version = "unknown"
      end
    end

    def attributes
      instance_values
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

    #exclude validation fields in the JSON output
    def as_json(options={})
      super(options.merge({:except => [:errors, :validation_context]}))
    end

    def to_json(options={})
      if self.valid?
        super(options)
      else
        raise "Article Card is not valid - please remedy the following errors:" << self.errors.messages.to_s
      end    
    end 

  end
end

