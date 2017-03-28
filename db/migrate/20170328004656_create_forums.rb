class CreateForums < ActiveRecord::Migration[5.0]
  def change
    create_table :forums do |t|
      t.integer :project_id

      t.timestamps
    end
  end
end
