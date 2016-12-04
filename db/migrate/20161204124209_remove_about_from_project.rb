class RemoveAboutFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :about, :text
  end
end
