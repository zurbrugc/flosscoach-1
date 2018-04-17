class CreateJoinTableTagTopic < ActiveRecord::Migration[5.0]
  def change
     create_join_table :tags, :topics do |t|
       t.index [:tag_id, :topic_id]
     end
   end
end
