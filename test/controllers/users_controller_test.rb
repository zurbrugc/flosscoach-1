require 'test_helper'

class UsersControllerTest  < ActionDispatch::IntegrationTest

  test "no clearing fields on error in user sign up" do
      #issue number #78 on gitlab
      params = {name: 'Victor', email: 'testeteste.com'}
      post users_url, params: {user: params}
      assert :unprocessable_entity

      assert_select '#user_name' do
        assert_select "[value=?]", params[:name]
      end

      assert_select '#user_email' do
        assert_select "[value=?]", params[:email]
      end
  end

  test "access profile URL generated from username" do
    user = create(:user)
    get user_url(user.username), params: {id: user.username}
    assert_response :success

    assert_select '.profile-user span.name', user.name
  end

  test "register user" do
    user_attributes = {name: 'Victor', email: 'imatheusfsantos@gmail.com',
                        username: 'victor', password: 'victor123', password_confirmation: 'victor123'}
    post users_url, params: {user: user_attributes}

    assert_equal User.first.name, user_attributes[:name]
  end
end
