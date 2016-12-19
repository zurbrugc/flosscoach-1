class OwnerProject < ActiveRecord::Base
  	belongs_to :project, :autosave => true
 	belongs_to :user, :autosave => true

	accepts_nested_attributes_for :project
	accepts_nested_attributes_for :user
	
	audited associated_with: :project
	audited associated_with: :user
end
