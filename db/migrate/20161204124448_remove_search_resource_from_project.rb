class RemoveSearchResourceFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :search_resource, :text
  end
end
