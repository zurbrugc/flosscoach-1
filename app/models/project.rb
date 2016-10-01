class Project < ActiveRecord::Base

	belongs_to :languages 
	belongs_to :operational_systems 
	belongs_to :tools
	has_many :widgets

	has_many :owner_projects
  has_many :owners, through: :owner_projects, :source => :user

  has_many :favoriter_projects
  has_many :fans, through: :favoriter_projects, :source => :user


def self.search(search)
  if search
    Project.where('name LIKE ?', "%#{search}%")
  else
    Project.all
  end
end


end
