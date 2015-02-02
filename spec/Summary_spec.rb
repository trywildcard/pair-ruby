require 'spec_helper'

describe WildcardPair::Summary do 

describe '#nil_summary_description' do
	summary = WildcardPair::Summary.new title: "cool"

	it "nil_summary_description" do
		expect(summary.valid?).to eql false
	end
end

describe '#nil_summary_title' do
	summary = WildcardPair::Summary.new description: "cool"

	it "nil_summary_title" do
		expect(summary.valid?).to eql false
	end
end

describe '#valid_summary' do
	summary = WildcardPair::Summary.new title: 'http://summary.com', description: "cool"

	it "valid summary" do
		expect(summary.valid?).to eql true
	end
end

describe '#valid_summary_with_image' do
	image = WildcardPair::Media::Image.new image_url: 'http://image.com', image_caption: "cool"
	summary = WildcardPair::Summary.new title: 'http://summary.com', description: "cool", media: image

	it "valid summary with image" do
		expect(summary.valid?).to eql true
	end
end

end