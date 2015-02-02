require_relative 'Object.rb'

module WildcardPair  
  class Price < WildcardPair::Object

    attr_accessor :price, :currency

    validates :price, presence: true, numericality: {greater_than_or_equal_to: 0}
 
    def initialize(attributes = {})
      #let's set currency to USD by default
      @currency = "USD"

      super
    end
  end
end