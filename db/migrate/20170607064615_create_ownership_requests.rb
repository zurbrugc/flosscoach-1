class CreateOwnershipRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :ownership_requests do |t|
      t.integer :user_id
      t.integer :project_id
      t.boolean :approved

      t.timestamps
    end
  end
end
