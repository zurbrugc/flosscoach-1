class AddColumnTagsToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :tags, :string, default: [], array:true
  end
end
