class AddColumnProjectIdToOwnerProject < ActiveRecord::Migration
  def change
    add_column :owner_projects, :project_id, :integer
  end
end
