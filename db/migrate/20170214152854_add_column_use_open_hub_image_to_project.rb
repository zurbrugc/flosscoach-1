class AddColumnUseOpenHubImageToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :use_open_hub_image, :boolean
  end
end
