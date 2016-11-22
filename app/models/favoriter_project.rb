class FavoriterProject < ActiveRecord::Base
	belongs_to :project, :autosave => true
 	belongs_to :user, :autosave => true

	accepts_nested_attributes_for :project
	accepts_nested_attributes_for :user

	validates_uniqueness_of :user_id, :scope => :project_id
end
