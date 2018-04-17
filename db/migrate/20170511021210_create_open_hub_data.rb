class CreateOpenHubData < ActiveRecord::Migration[5.0]
  def change
    create_table :open_hub_data do |t|
      t.integer :open_hub_id
      t.string :name
      t.string :url
      t.text :description
      t.string :homepage_url
      t.string :logo_url
      t.string :vanity_url
      t.string :download_url

      t.timestamps
    end
  end
end
