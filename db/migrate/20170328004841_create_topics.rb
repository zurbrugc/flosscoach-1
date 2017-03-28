class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.integer :forum_id
      t.string :title
      t.boolean :locked
      t.datetime :locked_at
      t.integer :user_id
      
      t.timestamps
    end
  end
end
