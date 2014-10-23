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

end