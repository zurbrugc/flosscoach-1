class RemoveOperatingSystemIdFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :operating_system_id, :integer
  end
end
