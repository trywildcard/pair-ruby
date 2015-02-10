require 'spec_helper'

describe WildcardPair::Target do 

describe '#nil_target_url' do
	target = WildcardPair::Target.new

	it "nil_target_url" do
		expect(target.valid?).to eql false
	end
end

describe '#valid_target' do
	target = WildcardPair::Target.new url: "http://spectrum.ieee.org/view-from-the-valley/at-work/tech-careers/massive-worldwide-layoff-underway-at-ibm"

	it "valid target" do
		expect(target.valid?).to eql true
	end
end

describe '#complete_target' do
	target = WildcardPair::Target.new url: "http://spectrum.ieee.org/view-from-the-valley/at-work/tech-careers/massive-worldwide-layoff-underway-at-ibm", 
		title: "Massive WorldWide Layoff Underway at IBM",
		description: "IBM layoffs started last month.  Details to follow.",
		publication_date: "2015-02-02T00:00:00.000+0000" 

	it "complete target" do
		expect(target.valid?).to eql true
	end
end

end