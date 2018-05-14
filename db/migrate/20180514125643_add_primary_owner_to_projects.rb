class AddPrimaryOwnerToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :primary_owner, :integer
  end
end
