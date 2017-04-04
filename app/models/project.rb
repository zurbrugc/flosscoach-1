class Project < ApplicationRecord
  audited
  validates_presence_of :name
  validates_uniqueness_of :name

  audited associated_with: :owners
  belongs_to :user
  has_many :widgets, :dependent => :destroy
  has_associated_audits
  has_and_belongs_to_many :owners, class_name: 'User'
  has_one :forum

  has_many :favoriter_projects
  has_many :fans, through: :favoriter_projects, :source => :user
  has_many :comments, through: :widgets
  mount_uploader :avatar, AvatarUploader
  validates :avatar, file_size: { less_than: 3.megabytes }
  scope :order_by_fans_count, -> {
  joins(:fans).select('projects.*, COUNT(user_id) as user_count').group('projects.id').order('user_count DESC')
  }

  def photo_url
    if use_open_hub_image
      open_hub_image_url  || "/assets/no-image.png"
    elsif !avatar.url.nil?
      avatar.url
    else
      "/assets/no-image.png"
    end
  end

  def photo_url_uploaded
      avatar.url
  end

  def owner?(user)
    self.owners.include?(user)
  end

  def self.search(search)
    if search
      Project.where('name LIKE ?', "%#{search}%")
    else
      Project.all
    end
  end
end
