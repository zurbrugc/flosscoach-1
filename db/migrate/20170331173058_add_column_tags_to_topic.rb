class AddColumnTagsToTopic < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :tags, :string, default: [], array:true
  end
end
