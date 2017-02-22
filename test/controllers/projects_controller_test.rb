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

  test "update a project" do
    user = create(:user, email: "victor@orochi.com.br", password:"batata")
    post users_login_url, params: {user: {email: "victor@orochi.com.br", password:"batata"}}
    assert_redirected_to projects_url

    post projects_url, params: {project: {name: "Teste", description: "lol"}}
    project = Project.first
    assert_redirected_to project_url(project)

    put project_url(project), params: {project: {id: project.id, name: "Batata"}}
    assert_response :ok
    project = Project.first #reload
    assert_equal "Batata", project.name
  end

  test "non-admin of a project tries to access edit page" do
    #login routine to fill current_user

    user = create(:user, email: "victor@orochi.com.br", password:"batata")
    post users_login_url, params: {user: {email: "victor@orochi.com.br", password:"batata"}}
    assert_redirected_to projects_url

    post projects_url, params: {project: {name: "Teste", description: "lol"}}
    project = Project.first
    assert_redirected_to project_url(project)

    project.owners.delete(user)
    assert_not project.owner?(user)

    get edit_project_url(project)
    assert_response :unauthorized
    assert_select "h1.page-title", Project.first.name

    project.owners << user
    assert project.owner?(user)

    get edit_project_url(project)
    assert_response :success
  end

  test "non-admin of a project tries to update" do
    user = create(:user, email: "victor@orochi.com.br", password:"batata")
    post users_login_url, params: {user: {email: "victor@orochi.com.br", password:"batata"}}
    assert_redirected_to projects_url

    post projects_url, params: {project: {name: "Teste", description: "lol"}}
    project = Project.first
    assert_redirected_to project_url(project)

    project.owners.delete(user)
    assert_not project.owner?(user)
    put project_url(project), params: {project: { id: project.id, name: "Batata"}}
    assert_response :unauthorized
  end
end
