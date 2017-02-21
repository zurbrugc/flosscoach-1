require 'test_helper'

class FavoritesProjectControllerTest <  ActionDispatch::IntegrationTest
  test "favorite a project" do
    #login routine to fill current_user
    user = create(:user, email: "victor@orochi.com.br", password:"batata")
    post users_login_url, params: {user: {email: "victor@orochi.com.br", password:"batata"}}

    post projects_url, params: {project: {name: "Teste", description: "lol"}}
    project = Project.first

    get project_url(Project.first)
    assert_select 'input.favorite-button' do
      assert_select "[value=?]","Favorite this project"
    end

    post project_favorite_url(project)

    get project_url(Project.first)
    assert_select 'input.disfavorite-button' do
      assert_select "[value=?]","Project favorited"
    end
  end

  test "disfavorite a project" do
    #login routine to fill current_user
    user = create(:user, email: "victor@orochi.com.br", password:"batata")
    post users_login_url, params: {user: {email: "victor@orochi.com.br", password:"batata"}}

    post projects_url, params: {project: {name: "Teste", description: "lol"}}
    project = Project.first

    user.favorite_project(project)

    get project_url(Project.first)
    assert_select 'input.disfavorite-button' do
      assert_select "[value=?]","Project favorited"
    end

    delete project_favorite_url(project)

    get project_url(Project.first)
    assert_select 'input.favorite-button' do
      assert_select "[value=?]","Favorite this project"
    end
  end
end
