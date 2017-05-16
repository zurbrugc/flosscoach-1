class AddOpenHubIdToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :open_hub_id, :integer
  end
end
