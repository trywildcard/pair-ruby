#!/usr/bin/env ruby -wKU

require_relative 'Card.rb'

module WildcardPair
  class ProductCard < WildcardPair::Card
    private

    attr_accessor :offers, :product

    public

    attr_reader :offers, :product

    validate :validateOffers
    validate :validateProduct

    def initialize(attributes = {})
      super
      @card_type = 'product'
    end

    def populate_from_metatags(web_url)
      @web_url=web_url
      metatags = WildcardPair::ExtractMetaTags.extract(@web_url)

      ##now that we've extracted metatags, create a Product and Offer object with it
      self.product=WildcardPair::Product.new metatags: metatags
      self.offers=WildcardPair::Offer.new metatags: metatags
      self.app_link_ios=metatags['applink_ios']
      self.app_link_android=metatags['applink_android']
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
        errors.add(:offers, 'At least one offer is required')
        return
      end

      @offers.each do |offer|
        if !offer.is_a?(Offer)
          errors.add(:offers, "At least one of the offers is invalid")
        elsif !offer.valid?
          offer.errors.each do |error, msg|
            errors["offer[%s]" % error] = msg
          end
        end
      end
    end

    def validateProduct
      if @product.nil? || !@product.is_a?(Product)
        errors.add(:product, "A product is required")
        return
      end

      if !@product.nil?
        if !@product.valid?
          @product.errors.each do |error, msg|
            errors["product[%s]" % error] = msg
          end
        end
      end
    end


  end
end

