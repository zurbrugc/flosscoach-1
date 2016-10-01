class AddColumnUserIdToFavoriterProject < ActiveRecord::Migration
  def change
    add_column :favoriter_projects, :user_id, :integer
  end
end
