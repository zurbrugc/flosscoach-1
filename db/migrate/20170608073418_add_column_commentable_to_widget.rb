class AddColumnCommentableToWidget < ActiveRecord::Migration[5.0]
  def change
    add_column :widgets, :commentable, :boolean, default: true
  end
end
