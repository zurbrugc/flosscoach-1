class CreateDefaultTips < ActiveRecord::Migration[5.0]
  def change
    create_table :default_tips do |t|
      t.string :title
      t.text :content
      t.string :widget_slug

      t.timestamps
    end
  end
end
