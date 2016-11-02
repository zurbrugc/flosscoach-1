class AddOperatingSystemIdToProject < ActiveRecord::Migration
  def change
    add_column :projects, :operating_system_id, :integer
    add_index  :projects, :operating_system_id
  end
end
