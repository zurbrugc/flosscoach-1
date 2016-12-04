class RemoveDocumentationFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :documentation, :text
  end
end
