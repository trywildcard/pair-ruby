require 'spec_helper'

describe WildcardPair::Rating do 

describe '#nil_rating' do
	rating = WildcardPair::Rating.new minimum_rating: 0, maximum_rating: 10

	it "nil_rating" do
		expect(rating.valid?).to eql false
	end
end

describe '#nil_min_rating' do
	rating = WildcardPair::Rating.new rating: 5, minimum_rating: 10

	it "nil_min_rating" do
		expect(rating.valid?).to eql false
	end
end

describe '#nil_max_rating' do
	rating = WildcardPair::Rating.new rating: 5, maximum_rating: 0

	it "nil_max_rating" do
		expect(rating.valid?).to eql false
	end
end

describe '#valid_rating' do
	rating = WildcardPair::Rating.new rating: 5, minimum_rating: 0, maximum_rating: 10

	it "valid rating" do
		expect(rating.valid?).to eql true
	end
end

end