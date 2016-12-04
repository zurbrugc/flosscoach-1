class RemoveTechnicalSkillFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :technical_skill, :text
  end
end
