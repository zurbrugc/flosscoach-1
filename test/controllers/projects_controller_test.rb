require 'test_helper'

class ProjectsControllerTest <  ActionDispatch::IntegrationTest
  test "create a project from OpenHub data" do
    open_session do |sess|
      user = create(:user, email: "victor@orochi.com.br", password:"batata")
      sess.post users_login_url, params: { user: {email: "victor@orochi.com.br", password:"batata"}}
      sess.assert_response :success
      sess.session[:user_id] = user.id

      project_params = {name: "Firefox", description: "Teste" }
      sess.post projects_url, params: {project: project_params, openhub_check: false}
      print sess.response.body
      sess.assert_response :created
    end




  end
end
