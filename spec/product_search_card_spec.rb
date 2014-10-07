require 'spec_helper'

describe WildcardPair::ProductSearchCard do
  
before :each do
  price = WildcardPair::Price.new price: 5
  price2 = WildcardPair::Price.new price: 7.99
    @validsearchresult = WildcardPair::ProductSearchResult.new price: price, name: 'ProductResult', product_card_url: 'http://brand.com/product/122', image_url: 'http://brand.com/product/122/image.jpg'
    @validsearchresult2 = WildcardPair::ProductSearchResult.new price: price2, name: 'Product Result', product_card_url: 'http://brand.com/product/123', image_url: 'http://brand.com/product/123/image.jpg'
    @validsearchresults = [@validsearchresult, @validsearchresult2]
end

describe '#new' do
  it "takes returns a ProductSearchCard object" do
    product_search_card = WildcardPair::ProductSearchCard.new products: @validsearchresult, total_results: 2
    product_search_card.should be_an_instance_of WildcardPair::ProductSearchCard   
    product_search_card.products.is_a?(Array).should eql true
    product_search_card.card_type.should eql 'product_search'
    expect {product_search_card.to_json}.not_to raise_error
  end
end

describe '#new2' do
  it "takes returns a ProductCard object" do
    product_search_card2 = WildcardPair::ProductSearchCard.new products: @validsearchresults, total_results: 2
    product_search_card2.should be_an_instance_of WildcardPair::ProductSearchCard
    product_search_card2.valid?.should eql true
    product_search_card2.valid?.should eql true
    product_search_card2.products.is_a?(Array).should eql true
    product_search_card2.card_type.should eql 'product_search'
    expect {product_search_card2.to_json}.not_to raise_error
  end
end

describe '#no_total_results' do
  it "no total results" do
    product_search_card = WildcardPair::ProductSearchCard.new products: @validsearchresults
    product_search_card2 = WildcardPair::ProductSearchCard.new products: @validsearchresults, total_results: nil
    
    product_search_card.valid?.should eql false
    product_search_card2.valid?.should eql false
    expect {product_search_card.to_json}.to raise_error(RuntimeError)
  end
end

describe '#invalid_total_results' do
  it "invalid_total_results" do
    product_search_card = WildcardPair::ProductSearchCard.new products: @validsearchresults, total_results: -10
    
    product_search_card.valid?.should eql false
    expect {product_search_card.to_json}.to raise_error(RuntimeError)
  end
end

describe '#total_results' do
  it "total_results" do
    product_search_card = WildcardPair::ProductSearchCard.new products: @validsearchresults, total_results: 2
    product_search_card.valid?.should eql true
    product_search_card.total_results.should eql 2
    expect {product_search_card.to_json}.not_to raise_error
  end
end

describe '#nosearchresults' do
  product_search_card = WildcardPair::ProductSearchCard.new products: nil, total_results: 2
  it "nosearchresults" do
    product_search_card.valid?.should eql false
    expect {product_search_card.to_json}.to raise_error(RuntimeError)
  end
end

describe '#invalidsearchresults' do
  invalidprice = WildcardPair::Price.new price: -4.50, currency: "USD"
  invalidSearchResult = WildcardPair::ProductSearchResult.new price: invalidprice, name: 'ProductResult', product_card_url: 'http://brand.com/product/123', image_url: 'http://brand.com/product/123/image.jpg'

  invalidsearchresults1 = [@validsearchresult, @validsearchresult2, invalidSearchResult]
  invalidsearchresults2 = [@validsearchresult, @validsearchresult2, nil]

  product_search_card = WildcardPair::ProductSearchCard.new products: invalidsearchresults1, total_results: 3
  product_search_card2 = WildcardPair::ProductSearchCard.new products: invalidsearchresults2, total_results: 3

  it "invalidsearchresults" do
    product_search_card.valid?.should eql false
    product_search_card2.valid?.should eql false
    expect {product_search_card.to_json}.to raise_error(RuntimeError)
    expect {product_search_card2.to_json}.to raise_error(RuntimeError)
  end
end

describe "product search card" do
  it "is built from json" do
    json = File.read("spec/fixtures/example_product_search_card.json")
    product_search_card = WildcardPair::ProductSearchCard.new
    product_search_card.from_json(json)
    product_search_card.valid?
    expect(product_search_card.valid?).to be(true)
    expect(JSON.parse(product_search_card.to_json)).to eq(JSON.parse(json)) 
  end
end

end