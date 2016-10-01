class CreateFavoriterProjects < ActiveRecord::Migration
  def change
    create_table :favoriter_projects do |t|

      t.timestamps null: false
    end
  end
end
