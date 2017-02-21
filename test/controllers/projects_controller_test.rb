require 'test_helper'

class ProjectsControllerTest <  ActionDispatch::IntegrationTest
  test "create new project" do
    #login routine to fill current_user
    user = create(:user, email: "victor@orochi.com.br", password:"batata")
    post users_login_url, params: {user: {email: "victor@orochi.com.br", password:"batata"}}
    assert_redirected_to projects_url

    post projects_url, params: {project: {name: "Teste", description: "lol"}}
    assert_redirected_to project_url(Project.first)

    get project_url(Project.first)
    assert_select "h1.page-title", Project.first.name
  end

end
