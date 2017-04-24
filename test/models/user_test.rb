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

  test "user search" do

    ricardo = create(:user, name: "Ricardo", username: "hirugamesh", email: "fernando@bol.com.br")
    pedro = create(:user, name: "Pedro", username: "pedro", email: "pedro@bol.com.br")

    assert_equal ricardo, User.search("Ricardo").first
    assert_equal ricardo, User.search("hirugamesh").first
    assert_equal ricardo, User.search("fernando@bol.com.br").first


    assert_equal pedro, User.search("Pedro").first
    assert_equal pedro, User.search("pedro").first
    assert_equal pedro, User.search("pedro@bol.com.br").first
    assert_equal 1, User.search("pedro").count

  end

end
