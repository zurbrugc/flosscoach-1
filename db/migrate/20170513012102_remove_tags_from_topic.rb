class RemoveTagsFromTopic < ActiveRecord::Migration[5.0]
  def change
    remove_column :topics, :tags, :text
  end
end
