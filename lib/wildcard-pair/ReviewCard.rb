#!/usr/bin/env ruby -wKU

require 'active_model'
require_relative 'hash_mappable.rb'

module WildcardPair
  class ReviewCard
    private

    attr_accessor :review, :card_type, :pair_version

    public

    include ActiveModel::Validations
    include ActiveModel::Serializers::JSON
    include WildcardPair::HashMappable

    attr_accessor :web_url
    attr_reader :review, :card_type, :pair_version

    validates :web_url, presence: true
    validate :validate_review

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end

      @card_type = 'review'

      if !Gem.loaded_specs['wildcard-pair'].nil?
        @pair_version = Gem.loaded_specs['wildcard-pair'].version.to_s
      else
        @pair_version = "unknown"
      end
    end

    def attributes
      instance_values
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

    #exclude validation fields in the JSON output
    def as_json(options={})
      super(options.merge({:except => [:errors, :validation_context]}))
    end

    def to_json(options={})
      if self.valid?
        super(options)
      else
        raise "Review Card is not valid - please remedy the following errors:" << self.errors.messages.to_s
      end    
    end 

  end
end

