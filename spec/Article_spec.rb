require 'spec_helper'

describe WildcardPair::Article do

describe '#nil_name' do
	article = WildcardPair::Article.new html_content: '<span></span>'
  it "nil_name" do
    expect(article.valid?).to eql false
  end
end

describe '#nil_html_content' do
  article = WildcardPair::Article.new title: 'article title'
  it "nil_html_content" do
    expect(article.valid?).to eql false
  end
end

describe '#valid_article' do
	article = WildcardPair::Article.new title: 'article title', html_content: '<span></span>'
	it "valid_article" do
		expect(article.valid?).to eql true
	end
end

describe '#article_with_video' do
	article = WildcardPair::Article.new title: 'article title', html_content: '<span></span>'
	video = WildcardPair::Media::Video.new title: 'video', embedded_url: 'http://video.com', embedded_url_width: 100, embedded_url_height: 100
	article.media = video
	it "article_with_video" do
		expect(article.valid?).to eql true
		expect(article.media).to eql video
	end
end

describe '#article_with_image' do
	article = WildcardPair::Article.new title: 'article title', html_content: '<span></span>'
	image = WildcardPair::Media::Image.new image_url: 'http://image.com', image_caption: "cool"
	article.media = image
	it "article_with_image" do
		expect(article.valid?).to eql true
		expect(article.media).to eql image
	end
end

describe '#article_with_invalid_image' do
	article = WildcardPair::Article.new title: 'article title', html_content: '<span></span>'
	image = WildcardPair::Media::Image.new image_caption: "cool"
	article.media = image
	it "article_with_invalid_image" do
		expect(article.valid?).to eql false
	end
end

end