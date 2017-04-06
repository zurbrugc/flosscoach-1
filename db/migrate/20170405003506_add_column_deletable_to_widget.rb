class AddColumnDeletableToWidget < ActiveRecord::Migration[5.0]
  def change
    add_column :widgets, :deletable, :boolean, default: true
  end
end
