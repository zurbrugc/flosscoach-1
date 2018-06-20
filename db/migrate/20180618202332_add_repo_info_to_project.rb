class AddRepoInfoToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :repo_info, :string
  end
end
