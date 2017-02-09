require 'test_helper'

class LoginControllerTest < ActionDispatch::IntegrationTest
  test "login with email/password" do
    user = create(:user, email: "victor@orochi.com.br", password:"batata")
    post users_login_url, params: {user: {email: "victor@orochi.com.br", password:"batata"}}
    assert_redirected_to projects_url
  end
  test "login with wrong email/password" do
    user = create(:user, email: "victor@orochi.com.br", password:"batata")
    post users_login_url, params: {user: {email: "lucas@orochi.com.br", password:"batata"}}
    assert_response :unauthorized
  end
end
