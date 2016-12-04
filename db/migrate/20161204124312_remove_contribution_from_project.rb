class RemoveContributionFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :contribution, :text
  end
end
