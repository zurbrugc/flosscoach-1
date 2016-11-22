class AddColumnProjectIdToFavoriterProject < ActiveRecord::Migration
  def change
    add_column :favoriter_projects, :project_id, :integer
  end
end
