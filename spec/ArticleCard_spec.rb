require 'spec_helper'

describe WildcardPair::ArticleCard do

before :each do
	@article = WildcardPair::Article.new title: 'article title', html_content: '<span></span>'
	@image = WildcardPair::Media::Image.new image_url: 'http://image.com'
	@video = WildcardPair::Media::Video.new title: 'video', embedded_url: 'http://video.com', embedded_url_width: 100, embedded_url_height: 100
end

describe '#new' do
	it "builds an article card" do
		article_card = WildcardPair::ArticleCard.new web_url: "http://article.com", article: @article
		expect(article_card).to be_an_instance_of WildcardPair::ArticleCard
		expect(article_card.valid?).to eql true
		expect(article_card.card_type).to eql 'article'
		expect{article_card.to_json}.not_to raise_error
	end
end

describe '#new with video' do
	it "builds an article card with video" do
		@article.media = @video
		article_card = WildcardPair::ArticleCard.new web_url: "http://article.com", article: @article

		expect(article_card).to be_an_instance_of WildcardPair::ArticleCard
		expect(article_card.valid?).to eql true
		expect(article_card.card_type).to eql 'article'
		expect(article_card.article.media).to eql @video
		expect{article_card.to_json}.not_to raise_error
	end
end

describe '#new with image' do
	it "builds an article card with image" do
		@article.media = @image
		article_card = WildcardPair::ArticleCard.new web_url: "http://article.com", article: @article

		expect(article_card).to be_an_instance_of WildcardPair::ArticleCard
		expect(article_card.valid?).to eql true
		expect(article_card.card_type).to eql 'article'
		expect(article_card.article.media).to eql @image
		expect{article_card.to_json}.not_to raise_error
	end
end

describe '#invalid video' do
	it "builds an article card with invalid video" do
		video_invalid = WildcardPair::Media::Video.new title: 'video'
		@article.media = video_invalid
		article_card = WildcardPair::ArticleCard.new web_url: "http://article.com", 
			article: @article
		expect(article_card.valid?).to eql false
		expect{article_card.to_json}.to raise_error
	end
end

describe "article card from valid url metatags" do
  article_card = WildcardPair::ArticleCard.new
  article_card.populate_from_metatags('http://www.bbc.com/news/business-29424351')
  it "is built from json" do
    article_card.web_url.should eql 'http://www.bbc.com/news/business-29424351' 
    article_card.article.title.should eql 'Wonga sees profits more than halve' 
    article_card.article.media.image_url.should eql 'http://news.bbcimg.co.uk/media/images/77915000/jpg/_77915774_77914640.jpg'
    article_card.article.valid?.should eql true
    expect(article_card.valid?).to be(true)
  end
end

end