class RemoveSoftSkillFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :soft_skill, :text
  end
end
