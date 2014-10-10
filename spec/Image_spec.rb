require 'spec_helper'

describe WildcardPair::Media::Image do 

describe '#nil_image_url' do
	image = WildcardPair::Media::Image.new image_caption: "cool"

	it "nil_image_url" do
		expect(image.valid?).to eql false
	end
end

describe '#valid_image' do
	image = WildcardPair::Media::Image.new image_url: 'http://image.com', image_caption: "cool"

	it "valid image" do
		expect(image.valid?).to eql true
	end
end

end