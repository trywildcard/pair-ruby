require 'spec_helper'

describe WildcardPair::SummaryCard do

before :each do
	@summary = WildcardPair::Summary.new title: 'summary', description: 'cool summary'
end

describe '#new' do
	it "builds and returns a summary card" do
		summary_card = WildcardPair::SummaryCard.new web_url: "http://summary.com", summary: @summary
		expect(summary_card).to be_an_instance_of WildcardPair::SummaryCard
		expect(summary_card.valid?).to eql true
		expect(summary_card.card_type).to eql 'summary'
		expect(summary_card.summary).to eql @summary
		expect(summary_card.web_url).to eql "http://summary.com"
		expect{summary_card.to_json}.not_to raise_error
	end
end

describe '#complete' do
	it "builds and returns a summary card with summary" do
		@image = WildcardPair::Media::Image.new title: 'image', image_url: 'http://image.com', width: 100, height: 100
		@summary.media = @image
		summary_card = WildcardPair::SummaryCard.new web_url: "http://summary.com", summary: @summary
		expect(summary_card).to be_an_instance_of WildcardPair::SummaryCard
		expect(summary_card.valid?).to eql true
		expect(summary_card.card_type).to eql 'summary'
		expect(summary_card.summary.media).to eql @image
		expect{summary_card.to_json}.not_to raise_error
	end
end

describe '#no_web_url' do
	it "fails without a web_url" do
		summary_card = WildcardPair::SummaryCard.new summary: @summary
		expect(summary_card.valid?).to eql false
		expect{summary_card.to_json}.to raise_error
	end
end

describe '#no_summary' do
	it "fails without a summary" do
		summary_card = WildcardPair::SummaryCard.new web_url: "http://summarycard.com"
		expect(summary_card.valid?).to eql false
		expect{summary_card.to_json}.to raise_error
	end
end

describe '#invalid summary' do
	it "fails on invalid summary" do
		summary_invalid = WildcardPair::Summary.new title: 'summary'
		summary_card = WildcardPair::SummaryCard.new web_url: "http://summary.com", summary: summary_invalid
		expect{summary_card.to_json}.to raise_error
	end
end

end