class RenameOperationalSystems < ActiveRecord::Migration
  def self.up
    rename_table :operational_systems, :operating_systems
  end

  def self.down
    rename_table :operating_systems, :operational_systems
  end
end