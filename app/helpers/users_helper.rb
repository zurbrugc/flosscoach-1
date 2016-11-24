module UsersHelper

  def check_favorite_project(user_id, project_id)
    favorite_project = FavoriteProject.find_by(user_id: user_id, project_id: project_id)
    if favorite_project == nil
      return false
    else
      return true
    end
  end

end
