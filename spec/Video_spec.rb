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

describe 'nil_metatags' do
  video = WildcardPair::Media::Video.new metatags: nil
  it "nil_metatags" do
    video.valid?.should eql false
  end
end

describe 'empty_metatags' do
  video = WildcardPair::Media::Video.new metatags: {}
  it "empty_metatags" do
    video.valid?.should eql false
  end
end

describe 'valid_metatags' do
  metatags = {'title' => 'title', 'description' => 'description'}
  video = WildcardPair::Media::Video.new metatags: metatags
  it "valid_metatags" do
    video.title.should eql 'title'
    video.description.should eql 'description'
    video.valid?.should eql false
  end
end

describe 'valid_metatags' do
  metatags = {'title' => 'title', 'video_url' => 'video_url', 'applink_ios' => 'ios', 'applink_android' => 'android', 'video_width' => '2', 'video_height' => '1'}
  video = WildcardPair::Media::Video.new metatags: metatags
  it "valid_metatags" do
    video.title.should eql 'title'
    video.embedded_url.should eql 'video_url'
    video.app_link_android.should eql 'android'
    video.app_link_ios.should eql 'ios'
    video.embedded_url_height.should eql '1'
    video.embedded_url_width.should eql '2'
    video.valid?.should eql true
  end
end

end