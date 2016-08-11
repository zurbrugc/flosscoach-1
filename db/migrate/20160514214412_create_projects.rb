class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :project_page_url
      t.string :issues_tracker_url

      t.timestamps null: false
    end
  end
end
