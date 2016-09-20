require "rails_helper"

RSpec.describe User, type: :model do

	before do
		@user1 = User.new(id: 1, name: "user1", password: "abab")
		@user1.save
	end

	describe "#password" do
		it "changes the password" do
			@user1.password = "cdcd"
			expect(@user1.password).to eq "cdcd"
		end
	end

	describe "#valid_password" do
		it "validates the password" do
			@user1.valid_password?("abab") == true
		end
	end
end
