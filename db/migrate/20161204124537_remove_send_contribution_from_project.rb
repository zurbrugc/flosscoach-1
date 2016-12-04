class RemoveSendContributionFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :send_contribution, :text
  end
end
