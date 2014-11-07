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

describe 'nil_metatags' do
  product = WildcardPair::Product.new metatags: nil
  it "nil_metatags" do
    product.valid?.should eql false
  end
end

describe 'empty_metatags' do
  product = WildcardPair::Product.new metatags: {}
  it "empty_metatags" do
    product.valid?.should eql false
  end
end

describe 'valid_metatags' do
  metatags = {'title' => 'title', 'description' => 'description'}
  product = WildcardPair::Product.new metatags: metatags
  it "valid_metatags" do
    product.name.should eql 'title'
    product.description.should eql 'description'
    product.valid?.should eql false
  end
end

describe 'valid_metatags' do
  metatags = {'title' => 'title', 'image_url' => 'image_url', 'applink_ios' => 'ios', 'applink_android' => 'android'}
  product = WildcardPair::Product.new metatags: metatags
  it "valid_metatags" do
    product.name.should eql 'title'
    product.app_link_android.should eql 'android'
    product.app_link_ios.should eql 'ios'
    product.images.size.should eql 1
    product.valid?.should eql true
  end
end

end