class AddColumnOpenHubImageUrlToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :open_hub_image_url, :string
  end
end
