require 'active_model'
require_relative 'hash_mappable.rb'

module WildcardPair
  class ProductSearchResult
    include ActiveModel::Validations
    include ActiveModel::Serializers::JSON
    include WildcardPair::HashMappable

    attr_accessor :name, :price, :product_card_url, :image_url

    validates :name, presence: true
    validates :price, presence: true
    validates :product_card_url, presence: true
    validates :image_url, presence: true

    validate :validatePrice
        
    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end 
    end

    def attributes
      instance_values
    end

    def price=(price)
      @price = map_hash(price, WildcardPair::Price.new)
    end

    def validatePrice
      if @price.nil? || !@price.is_a?(Price) || !@price.valid?
        errors.add(:price, 'Price does not exist or is invalid')
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
        raise "ProductSearchResult is not valid - please remedy the following errors:" << self.errors.messages.to_s
      end   
    end 

  end
end