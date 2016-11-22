class Project < ActiveRecord::Base
  belongs_to :user
  has_many :widgets
  has_and_belongs_to_many :owners, class_name: 'User'


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
