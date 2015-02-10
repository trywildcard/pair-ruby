require 'spec_helper'

describe WildcardPair::VideoCard do

before :each do
	@video = WildcardPair::Media::Video.new title: 'video', embedded_url: 'http://video.com', embedded_url_width: 100, embedded_url_height: 100
end

describe '#new' do
	it "builds and returns a video card" do
		video_card = WildcardPair::VideoCard.new web_url: "http://video.com", media: @video
		expect(video_card).to be_an_instance_of WildcardPair::VideoCard
		expect(video_card.valid?).to eql true
		expect(video_card.card_type).to eql 'video'
		expect{video_card.to_json}.not_to raise_error
	end
end

describe '#no_web_url' do
	it "fails without a web_url" do
		video_card = WildcardPair::VideoCard.new media: @video
		expect(video_card.valid?).to eql false
		expect{video_card.to_json}.to raise_error
	end
end

describe '#no_video' do
	it "fails without a video" do
		video_card = WildcardPair::VideoCard.new web_url: "http://videocard.com"
		expect(video_card.valid?).to eql false
		expect{video_card.to_json}.to raise_error
	end
end

describe '#invalid video' do
	it "fails on invalid video" do
		video_invalid = WildcardPair::Media::Video.new title: 'video'
		video_card = WildcardPair::VideoCard.new web_url: "http://video.com", media: video_invalid
		expect{video_card.to_json}.to raise_error
	end
end

describe "video card from valid url metatags" do
  video_card = WildcardPair::VideoCard.new
  video_card.populate_from_metatags('https://www.youtube.com/watch?v=0RFfrsABtQo')
  it "is built from json" do
    video_card.web_url.should eql 'https://www.youtube.com/watch?v=0RFfrsABtQo' 
    video_card.media.title.should eql 'Best of Phantom: Cavaliers Practice' 
    video_card.media.description.should eql 'Take a look at the new-look Cleveland Cavaliers through the lens of the Phantom camera during a practice session. Visit nba.com/video for more highlights. Ab...' 
    expect(video_card.media.embedded_url.to_s.start_with?('https://www.youtube.com/embed/0RFfrsABtQo')).to eql true
    video_card.media.embedded_url_height.should eql '720' 
    video_card.media.embedded_url_width.should eql '1280' 
    video_card.media.app_link_ios.should eql 'vnd.youtube://www.youtube.com/watch?v=0RFfrsABtQo&feature=applinks'
    video_card.media.app_link_android.should eql 'http://www.youtube.com/watch?v=0RFfrsABtQo&feature=applinks'
    video_card.media.poster_image_url.should eql 'https://i.ytimg.com/vi/0RFfrsABtQo/maxresdefault.jpg'
    video_card.media.valid?.should eql true
    expect(video_card.valid?).to be(true)
  end
end

end