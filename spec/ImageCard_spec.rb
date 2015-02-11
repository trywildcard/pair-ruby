require 'spec_helper'

describe WildcardPair::ImageCard do

before :each do
	@image = WildcardPair::Media::Image.new title: 'image', image_url: 'http://image.com', width: 100, height: 100
end

describe '#new' do
	it "builds and returns a image card" do
		image_card = WildcardPair::ImageCard.new web_url: "http://image.com", media: @image
		expect(image_card).to be_an_instance_of WildcardPair::ImageCard
		expect(image_card.valid?).to eql true
		expect(image_card.card_type).to eql 'image'
		expect(image_card.media).to eql @image
		expect(image_card.web_url).to eql "http://image.com"
		expect{image_card.to_json}.not_to raise_error
	end
end

describe '#complete' do
	it "builds and returns a image card with all possible data" do
		@image.image_caption = "cool image!"
		@image.author = "Image Author"
		@image.publication_date = "2014-06-01T00:00:00.000+0000"
		image_card = WildcardPair::ImageCard.new web_url: "http://image.com", media: @image
		expect(image_card).to be_an_instance_of WildcardPair::ImageCard
		expect(image_card.valid?).to eql true
		expect(image_card.card_type).to eql 'image'
		expect(image_card.media.image_caption).to eql "cool image!"
		expect(image_card.media.author).to eql "Image Author"
		expect(image_card.media.publication_date).to eql "2014-06-01T00:00:00.000+0000"
		expect{image_card.to_json}.not_to raise_error
	end
end

describe '#no_web_url' do
	it "fails without a web_url" do
		image_card = WildcardPair::ImageCard.new media: @image
		expect(image_card.valid?).to eql false
		expect{image_card.to_json}.to raise_error
	end
end

describe '#no_image' do
	it "fails without a image" do
		image_card = WildcardPair::ImageCard.new web_url: "http://imagecard.com"
		expect(image_card.valid?).to eql false
		expect{image_card.to_json}.to raise_error
	end
end

describe '#invalid image' do
	it "fails on invalid image" do
		image_invalid = WildcardPair::Media::Image.new title: 'image'
		image_card = WildcardPair::ImageCard.new web_url: "http://image.com", media: image_invalid
		expect{image_card.to_json}.to raise_error
	end
end

describe "image card from valid url metatags" do
  image_card = WildcardPair::ImageCard.new
  image_card.populate_from_metatags('https://www.youtube.com/watch?v=0RFfrsABtQo')
  it "is built from json" do
    image_card.web_url.should eql 'https://www.youtube.com/watch?v=0RFfrsABtQo' 
    image_card.media.title.should eql 'Best of Phantom: Cavaliers Practice' 
    image_card.media.image_url.should eql 'https://i.ytimg.com/vi/0RFfrsABtQo/maxresdefault.jpg'
    image_card.media.image_caption.should eql 'Take a look at the new-look Cleveland Cavaliers through the lens of the Phantom camera during a practice session. Visit nba.com/video for more highlights. Ab...' 
    image_card.app_link_ios.should eql 'vnd.youtube://www.youtube.com/watch?v=0RFfrsABtQo&feature=applinks'
    image_card.app_link_android.should eql 'http://www.youtube.com/watch?v=0RFfrsABtQo&feature=applinks'
    image_card.media.valid?.should eql true
    expect(image_card.valid?).to be(true)
  end
end

end