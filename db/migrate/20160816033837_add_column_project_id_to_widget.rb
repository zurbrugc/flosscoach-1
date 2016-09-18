class AddColumnProjectIdToWidget < ActiveRecord::Migration
  def change
    add_column :widgets, :project_id, :integer
  end
end
