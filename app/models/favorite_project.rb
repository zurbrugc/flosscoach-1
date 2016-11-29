class FavoriteProject < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  def self.create_favorite_project(user_id, project_id)
    favorite_project = FavoriteProject.new(user_id: user_id, project_id: project_id)
    favorite_project.save
  end

end
