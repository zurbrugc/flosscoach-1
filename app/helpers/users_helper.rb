module UsersHelper

  def check_favorite_project(user_id, project_id)
    favorite_project = FavoriteProject.find_by(user_id: user_id, project_id: project_id)
    if favorite_project == nil
      return false
    else
      return true
    end
  end

  def is_favorited(project_id)
    favorited = FavoriteProject.find_by(project_id: project_id)
    if favorited == nil
      return false
    else
      return true
    end
  end

  def has_user_favorite_project(user_id)
    has_favorite_project = FavoriteProject.exists?(user_id: user_id)
    print has_favorite_project
    return has_favorite_project
  end
end
