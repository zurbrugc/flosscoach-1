class Project < ApplicationRecord
  audited
  audited associated_with: :owners
  belongs_to :user
  has_many :widgets, :dependent => :destroy
  has_associated_audits
  has_and_belongs_to_many :owners, class_name: 'User'

  has_many :favoriter_projects
  has_many :fans, through: :favoriter_projects, :source => :user
  has_many :comments, through: :widgets
  mount_uploader :avatar, AvatarUploader
  
  def self.search(search)
    if search
      Project.where('name LIKE ?', "%#{search}%")
    else
      Project.all
    end
  end
end
