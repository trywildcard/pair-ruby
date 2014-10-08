require 'spec_helper'

describe WildcardPair::Product do

describe '#nil_name' do
  product = WildcardPair::Product.new images: 'http://image.jpeg', gender: nil
  it "nil_name" do
    product.valid?.should eql false
  end
end

describe '#nil_images' do
  product = WildcardPair::Product.new name: 'product name', gender: nil
  it "nil_image" do
    product.valid?.should eql false
  end
end

describe '#nil_gender' do
  product = WildcardPair::Product.new name: 'product name', images: 'http://image.jpeg', gender: nil
  it "nil_gender" do
    product.valid?.should eql true
  end
end

describe '#one_image' do
  product = WildcardPair::Product.new name: 'product name', images: 'http://image.jpeg', gender: nil
  it "one_image" do
    product.images.is_a?(Array).should eql true
    product.images.length.should eql 1
    product.valid?.should eql true
  end
end

describe '#two_images' do
  images = ['http://image.jpeg', 'http://image2.jpeg']
  product = WildcardPair::Product.new name: 'product name', images: images, gender: nil
  it "two_image" do
    product.images.is_a?(Array).should eql true
    product.images.length.should eql 2
    product.valid?.should eql true
  end
end

describe '#invalid_gender' do
  product = WildcardPair::Product.new name: 'product name', images: 'http://image.jpeg', gender: 'malefemale'
  it "invalid_gender" do
    product.valid?.should eql false
  end
end

describe '#gender' do
  product = WildcardPair::Product.new name: 'product name', images: 'http://image.jpeg', gender: 'unisex'
  it "gender" do
    product.valid?.should eql true
    product.gender.should eql 'unisex'
  end
end

end