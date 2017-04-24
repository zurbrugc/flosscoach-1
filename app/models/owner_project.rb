class OwnerProject < ApplicationRecord
  	belongs_to :project, :autosave => true
 	belongs_to :user, :autosave => true

	accepts_nested_attributes_for :project
	accepts_nested_attributes_for :user

end
