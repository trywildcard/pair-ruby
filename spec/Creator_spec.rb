require 'spec_helper'

describe WildcardPair::Creator do

describe '#nil_name' do
	creator = WildcardPair::Creator.new favicon: 'http://www.trywildcard.com/images/favicon.ico'
  it "nil_name" do
    expect(creator.valid?).to eql false
  end
end

describe '#nil_favicon' do
  creator = WildcardPair::Creator.new name: 'Wildcard'
  it "nil_favicon" do
    expect(creator.valid?).to eql false
  end
end

describe '#valid_creator' do
	creator = WildcardPair::Creator.new name: 'Wildcard', favicon: 'http://www.trywildcard.com/images/favicon.ico'
	it "valid_creator" do
		expect(creator.valid?).to eql true
    expect(creator.name).to eql 'Wildcard'
    expect(creator.favicon).to eql 'http://www.trywildcard.com/images/favicon.ico'
	end
end

describe '#valid_creator' do
  creator = WildcardPair::Creator.new name: 'Wildcard', favicon: 'http://www.trywildcard.com/images/favicon.ico',
    ios_app_store_url: "https://itunes.apple.com/us/app/wildcard-browse-better-mobile/id930047790",
    android_app_store_url: "https://play.google.com/store/apps/details?id=com.trywildcard.android",
    url: "http://www.trywildcard.com"
  it "valid_creator with all fields" do
    expect(creator.valid?).to eql true
    expect(creator.name).to eql 'Wildcard'
    expect(creator.favicon).to eql 'http://www.trywildcard.com/images/favicon.ico'
    expect(creator.ios_app_store_url).to eql "https://itunes.apple.com/us/app/wildcard-browse-better-mobile/id930047790"
    expect(creator.android_app_store_url).to eql "https://play.google.com/store/apps/details?id=com.trywildcard.android"
    expect(creator.url).to eql 'http://www.trywildcard.com'
  end
end

end