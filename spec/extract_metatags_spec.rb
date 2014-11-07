require 'spec_helper'

describe WildcardPair::ExtractMetaTags do 

describe '#nil' do
	metatags = WildcardPair::ExtractMetaTags.extract(nil)

	it "nil" do
		metatags.should eql Hash.new
	end
end

describe '#empty' do
	metatags = WildcardPair::ExtractMetaTags.extract('')

	it "empty" do
		metatags.should eql Hash.new
	end
end

describe '#badurl' do
	metatags = WildcardPair::ExtractMetaTags.extract('http://12901kljsdfa0.net')

	it "badurl" do
		metatags.should eql Hash.new
	end
end

describe '#valid' do
	metatags = WildcardPair::ExtractMetaTags.extract('https://www.etsy.com/listing/128235512/etsy-i-buy-from-real-people-tote-bag')

	it "valid" do
		metatags.keys.size.should eql 6
	end
end

end