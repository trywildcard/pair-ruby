require 'spec_helper'

describe WildcardPair::ReviewCard do 

before :each do
	@review = WildcardPair::Review.new title: "cool review", html_content: "<span></span>"
	@rating = WildcardPair::Rating.new rating: 5, minimum_rating: 0, maximum_rating: 10
end

describe '#new' do
	it "creates and returns a ReviewCard" do
		review_card = WildcardPair::ReviewCard.new web_url: "http://reviewcard.com", review: @review
		expect(review_card).to be_an_instance_of WildcardPair::ReviewCard
		expect(review_card.valid?).to eql true
		expect(review_card.card_type).to eql 'review'
		expect{review_card.to_json}.not_to raise_error
	end
end

describe '#no_web_url' do
	it "fails without a web_url" do
		review_card = WildcardPair::ReviewCard.new review: @review
		expect(review_card.valid?).to eql false
		expect{review_card.to_json}.to raise_error
	end
end

describe '#no_review' do
	it "fails without a review" do
		review_card = WildcardPair::ReviewCard.new web_url: "http://reviewcard.com"
		expect(review_card.valid?).to eql false
		expect{review_card.to_json}.to raise_error
	end
end

describe '#with_rating' do
	it "creates and returns a ReviewCard with a rating" do
		@review.rating = @rating
		review_card = WildcardPair::ReviewCard.new web_url: "http://reviewcard.com", review: @review
		expect(review_card).to be_an_instance_of WildcardPair::ReviewCard
		expect(review_card.valid?).to eql true
		expect(review_card.card_type).to eql 'review'
		expect{review_card.to_json}.not_to raise_error
	end
end

describe '#with_invalid_rating' do
	it "fails on invalid rating" do
		@review.rating = WildcardPair::Rating.new rating: 5
		review_card = WildcardPair::ReviewCard.new web_url: "http://reviewcard.com", review: @review
		expect(review_card.valid?).to eql false
		expect{review_card.to_json}.to raise_error
	end
end

describe "review card from valid url metatags" do
  review_card = WildcardPair::ReviewCard.new
  review_card.populate_from_metatags('http://www.engadget.com/2013/09/09/lg-g2-review/')
  it "is built from json" do
    review_card.web_url.should eql 'http://www.engadget.com/2013/09/09/lg-g2-review/' 
    review_card.review.title.should eql 'LG G2 review' 
    review_card.review.media.image_url.should eql 'http://www.blogcdn.com/www.engadget.com/media/2013/09/g2review-1378739225.jpg'
    review_card.review.abstract_content.should eql 'There are a lot of smartphones out there now. You know this. To add to the confusion, many companies are now parading out multiple top-drawer phones: thi'
    review_card.app_link_ios.should eql 'com.aol.engadget://www.engadget.com/2013/09/09/lg-g2-review/'
    review_card.app_link_android.should eql 'engadget://lg-g2-review'
    review_card.review.valid?.should eql true
    expect(review_card.valid?).to be(true)
  end
end

end