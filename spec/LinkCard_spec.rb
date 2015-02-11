require 'spec_helper'

describe WildcardPair::LinkCard do

before :each do
	@target = WildcardPair::Target.new url: "http://spectrum.ieee.org/view-from-the-valley/at-work/tech-careers/massive-worldwide-layoff-underway-at-ibm", 
		title: "Massive WorldWide Layoff Underway at IBM",
		description: "IBM layoffs started last month.  Details to follow.",
		publication_date: "2015-02-02T00:00:00.000+0000"
end

describe '#new' do
	it "builds and returns a link card" do
		link_card = WildcardPair::LinkCard.new web_url: "http://linkcard.com", target: @target
		expect(link_card).to be_an_instance_of WildcardPair::LinkCard
		expect(link_card.valid?).to eql true
		expect(link_card.card_type).to eql 'link'
		expect(link_card.target).to eql @target
		expect(link_card.web_url).to eql "http://linkcard.com"
		expect{link_card.to_json}.not_to raise_error
	end
end

describe '#no_web_url' do
	it "fails without a web_url" do
		link_card = WildcardPair::LinkCard.new target: @target
		expect(link_card.valid?).to eql false
		expect{link_card.to_json}.to raise_error
	end
end

describe '#no_target' do
	it "fails without a target" do
		link_card = WildcardPair::LinkCard.new web_url: "http://linkcard.com"
		expect(link_card.valid?).to eql false
		expect{link_card.to_json}.to raise_error
	end
end

describe '#invalid target' do
	it "fails on invalid target" do
		target_invalid = WildcardPair::Target.new title: "Massive WorldWide Layoff Underway at IBM"
		link_card = WildcardPair::LinkCard.new web_url: "http://linkcard.com", target: target_invalid
		expect{link_card.to_json}.to raise_error
	end
end

describe "link card" do
  it "is built from json" do
    json = File.read("spec/fixtures/example_link_card.json")
    link_card = WildcardPair::LinkCard.new
    link_card.from_json(json)
    link_card.valid?
    expect(link_card.valid?).to be(true)
    expect(JSON.parse(link_card.to_json)).to eq(JSON.parse(json)) 
  end
end

end