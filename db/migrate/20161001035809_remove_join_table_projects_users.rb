class RemoveJoinTableProjectsUsers < ActiveRecord::Migration
  def change
  	drop_join_table :projects, :users 
  end
end
