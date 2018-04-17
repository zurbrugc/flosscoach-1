class AddColumnTypeToWidget < ActiveRecord::Migration[5.0]
  def change
    add_column :widgets, :type, :string
  end
end
