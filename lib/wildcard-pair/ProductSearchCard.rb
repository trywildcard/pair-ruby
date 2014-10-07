#ProductCard
#!/usr/bin/env ruby -wKU

require 'active_model'
require_relative 'hash_mappable.rb'

module WildcardPair
  class ProductSearchCard

    private

    attr_accessor :products, :card_type, :pair_version

    public

      include ActiveModel::Validations
      include ActiveModel::Serializers::JSON
      include WildcardPair::HashMappable

    attr_accessor :total_results

    attr_reader :products, :card_type, :pair_version

    validates :total_results, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
    validate :validateSearchResults

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end 

      @card_type = 'product_search'
      
      if !Gem.loaded_specs['wildcard-pair'].nil?
        @pair_version = Gem.loaded_specs['wildcard-pair'].version.to_s
      else
        @pair_version = "unknown"
      end
    end

    def attributes
      instance_values
    end

     def products=(products)
      @products ||= Array.new

      if products.is_a?(Array)
        products.each do |product|
          @products << map_hash(product, ProductSearchResult.new)
        end
      elsif products.is_a?(ProductSearchResult)
          @products << products
      else
        @products << map_hash(products, ProductSearchResult.new)
      end
    end

    def validateSearchResults
      if @products.nil?
        errors.add(:products, "Products can be empty, but must exist")
        return
      end

      @products.each do |product|
        if (!product.is_a?(ProductSearchResult)  || !product.valid?)
          errors.add(:products, "One of the products in the search result is invalid")
          return
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
        raise "Product Search Card is not valid - please remedy below errors:" << self.errors.messages.to_s
      end    
    end 

  end
end

