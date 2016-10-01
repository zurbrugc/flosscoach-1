class CreateOwnerProjects < ActiveRecord::Migration
  def change
    create_table :owner_projects do |t|

      t.timestamps null: false
    end
  end
end
