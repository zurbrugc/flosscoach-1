class OwnerProject < ApplicationRecord
  belongs_to :project, :autosave => true
 	belongs_to :user, :autosave => true
  validates_uniqueness_of :user_id, :scope => :project_id
	accepts_nested_attributes_for :project
	accepts_nested_attributes_for :user

end
