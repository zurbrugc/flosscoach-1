class AddColumnTagsToTopic < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :tags, :text, default: [].to_yaml, array:true
  end
end
