require 'test_helper'
class UserMailerTest < ActionDispatch::IntegrationTest

  def setup
    @emails = ActionMailer::Base.deliveries
    @emails.clear
  end

  test "send email for activation on register" do
    user_attributes = attributes_for(:user)
    post users_url, params: {user: user_attributes}
    assert_redirected_to sign_in_url

    mail = @emails.last
    assert_equal user_attributes[:email], mail.to.first

  end
end
