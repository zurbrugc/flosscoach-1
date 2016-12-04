class RemoveLanguageIdFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :language_id, :integer
  end
end
