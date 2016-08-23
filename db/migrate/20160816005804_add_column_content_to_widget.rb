class AddColumnContentToWidget < ActiveRecord::Migration
  def change
    add_column :widgets, :content, :text
  end
end
