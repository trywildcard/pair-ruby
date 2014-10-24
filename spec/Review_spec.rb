require 'spec_helper'

describe WildcardPair::Review do 

describe '#nil_title' do
	review = WildcardPair::Review.new html_content: "<span></span>"

	it "nil_title" do
		expect(review.valid?).to eql false
	end
end

describe '#nil_html_content' do
	review = WildcardPair::Review.new title: "cool review"

	it "nil_html_content" do
		expect(review.valid?).to eql false
	end
end

describe '#valid_review' do
	review = WildcardPair::Review.new title: "cool review", html_content: "<span></span>"

	it "valid review" do
		expect(review.valid?).to eql true
	end
end

describe '#review_with_rating' do
	review = WildcardPair::Review.new title: "cool review", html_content: "<span></span>"
	rating = WildcardPair::Rating.new rating: 5, minimum_rating: 0, maximum_rating: 10
	review.rating = rating

	it "review with rating" do
		expect(review.valid?).to eql true
		expect(review.rating).to eql rating
	end
end

describe '#review_with_invalid_rating' do
	review = WildcardPair::Review.new title: "cool review", html_content: "<span></span>"
	rating = WildcardPair::Rating.new rating: 5
	review.rating = rating

	it "review with invalid rating" do
		expect(review.valid?).to eql false
	end
end

end