class AddIssueToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :issue, :text
  end
end
