class Project < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  include Taggable

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :description
  validates :avatar, file_size: { less_than: 3.megabytes }

  belongs_to :user
  has_many :widgets, :dependent => :destroy
  has_and_belongs_to_many :owners, class_name: 'User'
  has_one :forum
  has_many :favoriter_projects
  has_many :fans, through: :favoriter_projects, :source => :user
  has_many :comments, through: :widgets

  has_one :open_hub_data

  before_create :transform_tags
  before_create :create_widgets

  attr_accessor :plain_tags

  def get_open_hub_data
    open_hub_data = OpenHubProject.find_by_name(self.name).to_open_hub_data

  end
  def recent?
    created_at > 2.day.ago
  end

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
      results = includes(:tags).where("projects.name LIKE ? OR projects.description LIKE ? OR tags.name LIKE ?", "%#{search}%","%#{search}%", "%#{search}%").references(:tags)
    else
      results = all
    end
    results.distinct
  end

  private
  def transform_tags
    if self.plain_tags
      self.tags << Tag.array_to_tags(plain_tags.split(","))
    end
  end
  def create_widgets
    self.widgets << Widget.defaults
  end
end
