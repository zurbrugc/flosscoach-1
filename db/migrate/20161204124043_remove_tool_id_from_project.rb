class RemoveToolIdFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :tool_id, :integer
  end
end
