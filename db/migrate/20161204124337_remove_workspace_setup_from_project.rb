class RemoveWorkspaceSetupFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :workspace_setup, :text
  end
end
