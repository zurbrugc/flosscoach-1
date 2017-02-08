ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
ActiveRecord::Migration.maintain_test_schema!

class ActiveSupport::TestCase

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  include FactoryGirl::Syntax::Methods
  # Add more helper methods to be used by all tests here...

  def set_current_user
    @current_user = create(:user, email: "victor@orochi.com.br", password:"batata")
    post :create, params: {user: {email: "victor@orochi.com.br", password:"batata"}}
    assert_response :success
  end
end
