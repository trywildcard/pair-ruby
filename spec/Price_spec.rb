require 'spec_helper'

describe WildcardPair::Price do

describe '#new' do
  it "takes returns a Price object" do
    price = WildcardPair::Price.new price: 5
    price.should be_an_instance_of WildcardPair::Price
    expect {price.to_json}.not_to raise_error
  end
end

describe '#validprice' do
  it "validprice" do
    price = WildcardPair::Price.new price: 5
    price.price.should eql 5
    price.currency.should eql "USD"
    expect {price.to_json}.not_to raise_error
  end
end

describe '#validpriceandcurrency' do
  it "validpriceandcurrency" do
    price = WildcardPair::Price.new price: 5, currency: "EUR"
    price.price.should eql 5
    price.currency.should eql "EUR"
    expect {price.to_json}.not_to raise_error
  end
end

describe '#invalidprice' do
  it "invalidprice" do
    price = WildcardPair::Price.new price: -4
    price.valid?.should eql false
    expect {price.to_json}.to raise_error
  end
end


end