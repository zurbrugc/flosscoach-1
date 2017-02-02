require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test "no clearing fields on error in user sign up" do
      #issue number #78 on gitlab
      params = {name: 'Victor', email: 'testeteste.com'}
      post :create, params: {user: params}
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
    get :show, id: user.username
    assert_response :success
  end
end
