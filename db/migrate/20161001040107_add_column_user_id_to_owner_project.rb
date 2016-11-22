class AddColumnUserIdToOwnerProject < ActiveRecord::Migration
  def change
    add_column :owner_projects, :user_id, :integer
  end
end
