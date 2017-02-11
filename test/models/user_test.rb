require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "create a user with a invalid email" do
    user = build(:user, email: "www.google.com")
    assert_not user.save, "User with invalid email has been saved!"
  end



  test "generate slug from username" do
    user = build(:user)
    username = user.username
    user.save

    assert_equal username, user.slug
  end

end
