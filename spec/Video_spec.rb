require 'spec_helper'

describe WildcardPair::Media::Video do 

describe '#nil_title' do
	video = WildcardPair::Media::Video.new embedded_url: 'http://video.com', embedded_url_width: 100, embedded_url_height: 100

	it "nil_title" do
		expect(video.valid?).to eql false
	end
end

describe '#nil_embedded_url' do
	video = WildcardPair::Media::Video.new title: 'video', embedded_url_width: 100, embedded_url_height: 100

	it "nil_embedded_url" do
		expect(video.valid?).to eql false
	end
end

describe '#nil_embedded_url_width' do
	video = WildcardPair::Media::Video.new title: 'video', embedded_url: 'http://video.com', embedded_url_height: 100

	it "nil_embedded_url_width" do
		expect(video.valid?).to eql false
	end
end

describe '#nil_embedded_url_height' do
	video = WildcardPair::Media::Video.new title: 'video', embedded_url: 'http://video.com', embedded_url_width: 100

	it "nil_embedded_url_height" do
		expect(video.valid?).to eql false
	end
end

describe '#valid_video' do
	video = WildcardPair::Media::Video.new title: 'video', embedded_url: 'http://video.com', embedded_url_width: 100, embedded_url_height: 100

	it "valid video" do
		expect(video.valid?).to eql true
	end
end

end