require 'spec_helper'

describe WildcardPair::Color do

describe '#new' do
  it "blank color object returns a Color object" do
    color = WildcardPair::Color.new 
    color.should be_an_instance_of WildcardPair::Color
    color.valid?.should eql true
    expect {color.to_json}.not_to raise_error
  end
end

describe '#invalid_color' do
  color = WildcardPair::Color.new display_name: "orange_red", swatch_url: "http://orange_red.com/image.jpg", value: "RGB(1,1,1)", mapping_color: "orange_red"
  it "invalid_color " do
    color.valid?.should eql false
  end
end

describe '#valid_color' do
  color = WildcardPair::Color.new display_name: "mint", swatch_url: "http://www.examplestore.com/swatches/mint.jpg", value: "RGB(62, 180, 137)", mapping_color: "green"
  it "valid_color " do
    color.valid?.should eql true
  end
end
  
 describe '#invalidcolors' do
   invalidcolor = WildcardPair::Color.new mapping_color: 'beige'
   invalidcolor2 = WildcardPair::Color.new mapping_color: 'aqua'
   invalidcolors = [invalidcolor, invalidcolor2]

   product = WildcardPair::Product.new name: 'product test', colors: invalidcolors
 
   it "invalidcolors" do
     product.valid?.should eql false
     expect {product.to_json}.to raise_error(RuntimeError)
   end
 end
 
 describe '#validcolors' do
   validcolor = WildcardPair::Color.new mapping_color: 'offwhite'
   validcolor2 = WildcardPair::Color.new mapping_color: 'black'
   validcolor3= WildcardPair::Color.new mapping_color: 'gray'
   validcolor4 = WildcardPair::Color.new mapping_color: 'gold'
   validcolor5 = WildcardPair::Color.new mapping_color: 'pink'
   validcolor6 = WildcardPair::Color.new mapping_color: 'transparent'
   validcolors =[validcolor, validcolor2, validcolor3, validcolor4, validcolor5, validcolor6]

   product = WildcardPair::Product.new name: 'product test', images: 'http://image.jpeg', colors: validcolor
   product2 = WildcardPair::Product.new name: 'product test', images: 'http://image.jpeg', colors: validcolors
 
   it "validcolors" do
     product.valid?.should eql true
     product2.valid?.should eql true
     expect {product.to_json}.not_to raise_error
   end
 end

end