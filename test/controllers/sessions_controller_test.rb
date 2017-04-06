require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "login with email/password" do
    login
    assert_redirected_to projects_url
  end
  test "login with wrong email/password" do
    post sign_in_url, params: {session: {email: "lucas@orochi.com.br", password:"batata"}}
    assert_response :unauthorized
  end
end
