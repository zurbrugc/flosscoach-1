class AddColumnTypeToComment < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :type, :string
  end
end
