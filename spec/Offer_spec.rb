require 'spec_helper'

describe WildcardPair::Offer do

describe '#new' do
  it "takes returns a Offer object" do
    price = WildcardPair::Price.new price: 5
    offer = WildcardPair::Offer.new price: price
    offer.should be_an_instance_of WildcardPair::Offer
    expect {offer.to_json}.not_to raise_error
  end
end

describe '#no_price' do
  offer = WildcardPair::Offer.new 
  offer2 = WildcardPair::Offer.new price: nil
  it "no price" do
    offer.valid?.should eql false
    offer2.valid?.should eql false
  end
end

describe '#invalid_price' do
  price = WildcardPair::Price.new price: -1
  offer = WildcardPair::Offer.new price: price
  it "invalidates negative price" do
    offer.valid?.should eql false
  end
end

describe '#no_original_price' do
  price = WildcardPair::Price.new price: 5
  offer = WildcardPair::Offer.new price: price, original_price: nil
  it "no original price" do
    offer.valid?.should eql true
  end
end

describe '#negative_original_price' do
  price = WildcardPair::Price.new price: 5
  originalprice = WildcardPair::Price.new price: -2
  offer = WildcardPair::Offer.new price: price, original_price: originalprice
  it "negative original price" do
    offer.valid?.should eql false
  end
end

describe '#original_price' do
  price = WildcardPair::Price.new price: 5
  originalprice = WildcardPair::Price.new price: 4
  offer = WildcardPair::Offer.new price: price, original_price: originalprice
  it "original price" do
    offer.valid?.should eql true
    offer.original_price.price.should eql 4
  end
end

describe '#no_shipping_cost' do
  price = WildcardPair::Price.new price: 5
  offer = WildcardPair::Offer.new price: price, shipping_cost: nil
  it "no shipping cost" do
    offer.valid?.should eql true
  end
end

describe '#negative_shipping_cost' do
  price = WildcardPair::Price.new price: 5
  shippingcost = WildcardPair::Price.new price: -2
  offer = WildcardPair::Offer.new price: price, shipping_cost: shippingcost
  it "negative shipping cost" do
    offer.valid?.should eql false
  end
end

describe '#shipping_cost' do
  price = WildcardPair::Price.new price: 5
  shippingcost = WildcardPair::Price.new price: 4
  offer = WildcardPair::Offer.new price: price, shipping_cost: shippingcost
  it "original price" do
    offer.valid?.should eql true
    offer.shipping_cost.price.should eql 4
  end
end

describe '#nil_description' do
  price = WildcardPair::Price.new price: 5
  offer = WildcardPair::Offer.new price: price, description: nil
  it "nil_description" do
    offer.valid?.should eql true
  end
end

describe '#empty_description' do
  price = WildcardPair::Price.new price: 5
  offer = WildcardPair::Offer.new price: price, description: ''
  it "empty shipping cost" do
    offer.valid?.should eql false
  end
end

describe '#description' do
  price = WildcardPair::Price.new price: 5
  offer = WildcardPair::Offer.new price: price, description: 'offer description'
  it "description" do
    offer.valid?.should eql true
    offer.description.should eql 'offer description'
  end
end

describe '#nil_availability' do
  price = WildcardPair::Price.new price: 5
  offer = WildcardPair::Offer.new price: price, availability: nil
  it "nil_availability" do
    offer.valid?.should eql true
  end
end

describe '#invalid_availability' do
  price = WildcardPair::Price.new price: 5
  offer = WildcardPair::Offer.new price: price, availability: 'NotExist'
  it "invalid_availability" do
    offer.valid?.should eql false
  end
end

describe '#availability' do
  price = WildcardPair::Price.new price: 5
  offer = WildcardPair::Offer.new price: price, availability: 'OnlineOnly'
  it "availability" do
    offer.valid?.should eql true
    offer.availability.should eql 'OnlineOnly'
  end
end

describe '#no_weight' do
  price = WildcardPair::Price.new price: 5
  offer = WildcardPair::Offer.new price: price, weight: nil
  it "no weight" do
    offer.valid?.should eql true
  end
end

describe '#negative_weight' do
  price = WildcardPair::Price.new price: 5
  offer = WildcardPair::Offer.new price: price, weight: -2
  it "negative weight" do
    offer.valid?.should eql false
  end
end

describe '#weight' do
  price = WildcardPair::Price.new price: 5
  offer = WildcardPair::Offer.new price: price, weight: 4.5
  it "weight" do
    offer.valid?.should eql true
    offer.weight.should eql 4.5
  end
end

describe '#no_quantity' do
  price = WildcardPair::Price.new price: 5
  offer = WildcardPair::Offer.new price: price, quantity: nil
  it "no quantity" do
    offer.valid?.should eql true
  end
end

describe '#negative_quantity' do
  price = WildcardPair::Price.new price: 5
  offer = WildcardPair::Offer.new price: price, quantity: -2
  it "negative quantity" do
    offer.valid?.should eql false
  end
end

describe '#non_integer_quantity' do
  price = WildcardPair::Price.new price: 5
  offer = WildcardPair::Offer.new price: price, quantity: 2.5
  it "non integer quantity" do
    offer.valid?.should eql false
  end
end

describe '#quantity' do
  price = WildcardPair::Price.new price: 5
  offer = WildcardPair::Offer.new price: price, quantity: 400
  it "quantity" do
    offer.valid?.should eql true
    offer.quantity.should eql 400
  end
end

#test to see if to_json raises error if invalid offer
describe '#invalidofferjson' do
  price = WildcardPair::Price.new price: 5
  offer = WildcardPair::Offer.new price: price, quantity: -100
  it "invalidofferjson" do
    expect {offer.to_json}.to raise_error(RuntimeError)
  end
end

end