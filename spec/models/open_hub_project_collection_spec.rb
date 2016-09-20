require "rails_helper"

RSpec.describe OpenHubProjectCollection, type: :model do

 describe "#initialize" do
  it "should return a hash with key 'result'" do
      parsed = Hash.new
      expect(OpenHubProjectCollection.new(parsed)).to eq(parsed['result'])
    end
 end

end
