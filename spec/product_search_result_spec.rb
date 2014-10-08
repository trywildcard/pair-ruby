require 'spec_helper'

describe WildcardPair::ProductSearchResult do

describe '#new' do
  it "takes returns a ProductSearchResult object" do
    price = WildcardPair::Price.new price: 5
    product_search_result = WildcardPair::ProductSearchResult.new price: price, name: 'ProductResult', product_card_url: 'http://brand.com/product/123', image_url: 'http://image.jpeg'
    product_search_result.should be_an_instance_of WildcardPair::ProductSearchResult
    product_search_result.price.price.should eql 5
    product_search_result.name.should eql 'ProductResult'
    product_search_result.product_card_url.should eql 'http://brand.com/product/123'
    product_search_result.image_url.should eql 'http://image.jpeg'
    expect {product_search_result.to_json}.not_to raise_error
  end
end

describe '#noname' do
  it "no name" do
    price = WildcardPair::Price.new price: 5
    product_search_result = WildcardPair::ProductSearchResult.new price: price, product_card_url: 'http://brand.com/product/123', image_url: 'http://image.jpeg'
    product_search_result.valid?.should eql false
    expect {product_search_result.to_json}.to raise_error(RuntimeError)
  end
end

describe '#noprice' do
  it "no price" do
    product_search_result = WildcardPair::ProductSearchResult.new name: 'ProductResult', product_card_url: 'http://brand.com/product/123', image_url: 'http://image.jpeg'
    product_search_result.valid?.should eql false
    expect {product_search_result.to_json}.to raise_error(RuntimeError)
  end
end

describe '#invalidprice' do
  it "no name" do
    invalidprice = WildcardPair::Price.new price: -4.50
    product_search_result = WildcardPair::ProductSearchResult.new price: invalidprice, name: 'ProductResult', product_card_url: 'http://brand.com/product/123', image_url: 'http://image.jpeg'
    product_search_result.valid?.should eql false
    expect {product_search_result.to_json}.to raise_error(RuntimeError)
  end
end

describe '#noproducturl' do
  it "no producturl" do
    product_search_result = WildcardPair::ProductSearchResult.new name: 'ProductResult', image_url: 'http://image.jpeg'
    product_search_result.valid?.should eql false
    expect {product_search_result.to_json}.to raise_error(RuntimeError)
  end
end

describe '#noimageurl' do
  it "no producturl" do
    price = WildcardPair::Price.new price: 5
    product_search_result = WildcardPair::ProductSearchResult.new price: price, name: 'ProductResult', product_card_url: 'http://brand.com/product/123'
    product_search_result.valid?.should eql false
    expect {product_search_result.to_json}.to raise_error(RuntimeError)
  end
end
end