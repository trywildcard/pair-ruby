require 'spec_helper'

describe WildcardPair::VideoCard do

before :each do
	@video = WildcardPair::Media::Video.new title: 'video', embedded_url: 'http://video.com', embedded_url_width: 100, embedded_url_height: 100
end

describe '#new' do
	it "builds and returns a video card" do
		video_card = WildcardPair::VideoCard.new web_url: "http://video.com", video: @video
		expect(video_card).to be_an_instance_of WildcardPair::VideoCard
		expect(video_card.valid?).to eql true
		expect(video_card.card_type).to eql 'video'
		expect{video_card.to_json}.not_to raise_error
	end
end

describe '#no_web_url' do
	it "fails without a web_url" do
		video_card = WildcardPair::VideoCard.new video: @video
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
		video_card = WildcardPair::VideoCard.new web_url: "http://video.com", video: video_invalid
		expect{video_card.to_json}.to raise_error
	end
end

end