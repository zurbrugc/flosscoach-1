require 'test_helper'

class ProjectsControllerTest <  ActionDispatch::IntegrationTest
  setup do
    login
  end

  test "create new project" do
    #login routine to fill current_user
    post projects_url, params: {project: {name: "Teste", description: "lol"}}
    assert_redirected_to project_url(Project.first)
    get project_url(Project.first)
  end

  test "update a project" do
    post projects_url, params: {project: {name: "Teste", description: "lol"}}
    project = Project.first
    assert_redirected_to project_url(project)

    put project_url(project), params: {project: {id: project.id, name: "Batata"}}
    assert_response :ok
    project = Project.first #reload
    assert_equal "Batata", project.name
  end

  test "non-admin of a project tries to access edit page" do
    post projects_url, params: {project: {name: "Teste", description: "lol"}}
    project = Project.first
    assert_redirected_to project_url(project)

    project.owners.delete(@current_user)
    assert_not project.owner?(@current_user)

    get edit_project_url(project)
    assert_response :unauthorized

    project.owners << @current_user
    assert project.owner?(@current_user)

    get edit_project_url(project)
    assert_response :success
  end

  test "non-admin of a project tries to update" do
    post projects_url, params: {project: {name: "Teste", description: "lol"}}
    project = Project.first
    assert_redirected_to project_url(project)

    project.owners.delete(@current_user)
    assert_not project.owner?(@current_user)
    put project_url(project), params: {project: { id: project.id, name: "Batata"}}
    assert_response :unauthorized
  end
end
