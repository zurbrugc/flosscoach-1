class RemoveResourceFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :resource, :text
  end
end
