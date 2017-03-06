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

  test "edit user" do
    user = create(:user, email: "victor@orochi.com.br", password:"batata")
    post users_login_url, params: {user: {email: "victor@orochi.com.br", password:"batata"}}
    assert_redirected_to projects_url

    #create method to fill form and submit
  end

  test "update user" do
    user = create(:user, email: "victor@orochi.com.br", password:"batata")
    post users_login_url, params: {user: {email: "victor@orochi.com.br", password:"batata"}}
    assert_redirected_to projects_url

    put user_url(user), params: {user:{twitter_link: "http://www.twitter.com/teste"} }
    assert_response :ok

    user = User.first
    assert_equal "http://www.twitter.com/teste", user.twitter_link

    put user_url(user), params: {user:{name: "Matias"} }
    assert_response :ok

    user = User.first
    assert_equal "Matias", user.name
  end
end
