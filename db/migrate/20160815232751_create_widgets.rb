class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.string :title, :null => false
      t.string :tab, :null => false
      t.string :slug
      t.integer :pos_x, :null => false
      t.integer :pos_y, :null => false
      t.integer :width, :null => false
      t.integer :height, :null => false
      t.boolean :closeable, :default => true
      t.boolean :resizeable, :default => true
      t.boolean :retractable, :default => true

      t.timestamps null: false
    end
  end
end
