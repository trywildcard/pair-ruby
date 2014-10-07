#!/usr/bin/env ruby -wKU

require 'active_model'
require_relative 'hash_mappable.rb'

module WildcardPair
  class ProductCard
    private

    attr_accessor :offers, :product, :card_type, :pair_version

    public

    include ActiveModel::Validations
    include ActiveModel::Serializers::JSON
    include WildcardPair::HashMappable

    attr_accessor :web_url
    attr_reader :offers, :card_type, :pair_version, :product

    validates :web_url, presence: true
    validate :validateOffers
    validate :validateProduct

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end

      @card_type = 'product'

      if !Gem.loaded_specs['wildcard-pair'].nil?
        @pair_version = Gem.loaded_specs['wildcard-pair'].version.to_s
      else
        @pair_version = "unknown"
      end
    end

    def attributes
      instance_values
    end

    def offers=(offers)
      @offers ||= Array.new

      if offers.is_a?(Array)
        offers.each do |offer|
          @offers << map_hash(offer, Offer.new)
        end
      elsif offers.is_a?(Offer)
          @offers << offers
      else
        @offers << map_hash(offers, Offer.new)
      end
    end

    def product=(product)
      @product = map_hash(product, WildcardPair::Product.new)
    end

    def validateOffers
      if @offers.nil? || (@offers.is_a?(Array) && !@offers.any?)
        errors.add(:offers, 'Atleast one offer is required')
        return
      end

      @offers.each do |offer|
        if (!offer.is_a?(Offer) || !offer.valid?)
          errors.add(:offers, "Atleast one of the offers is invalid")
          return
        end
      end
    end

    def validateProduct
      if @product.nil? || !@product.is_a?(Product) || !@product.valid?
        errors.add(:product, "A product is required")
        return
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
        raise "Product Card is not valid - please remedy the following errors:" << self.errors.messages.to_s
      end    
    end 

  end
end

