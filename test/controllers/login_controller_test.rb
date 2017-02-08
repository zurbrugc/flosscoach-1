require 'test_helper'

class LoginControllerTest < ActionController::TestCase
  test "login with email/password" do
    user = create(:user, email: "victor@orochi.com.br", password:"batata")
    post :create, params: {user: {email: "victor@orochi.com.br", password:"batata"}}
    assert_response :success
  end
  test "login with wrong email/password" do
    user = create(:user, email: "victor@orochi.com.br", password:"batata")
    post :create, params: {user: {email: "lucas@orochi.com.br", password:"batata"}}
    assert_response :unauthorized
  end
end
