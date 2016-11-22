class AddAttachmentImageProjectToProjects < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.attachment :image_project
    end
  end

  def self.down
    remove_attachment :projects, :image_project
  end
end
