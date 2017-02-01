require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "no clearing fields on error in user sign up" do
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

end
