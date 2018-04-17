class AddColumnEditableToWidget < ActiveRecord::Migration[5.0]
  def change
    add_column :widgets, :editable, :boolean, default:true
  end
end
