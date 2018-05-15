class Project < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  include Taggable

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :description, unless: :open_hub_id
  validates :avatar, file_size: { less_than: 3.megabytes }

  belongs_to :user
  has_many :widgets, :dependent => :destroy
  has_and_belongs_to_many :owners, class_name: 'User'
  has_one :forum, :dependent => :destroy
  has_many :favoriter_projects
  has_many :fans, through: :favoriter_projects, :source => :user
  has_many :comments, class_name: 'ProjectComment'

  has_many :ownership_requests, :dependent => :destroy
  has_many :pendent_ownership_requests, -> { pendent }, :class_name => 'OwnershipRequest'
  has_many :pendent_owners, :source => :user, through: :pendent_ownership_requests

  before_create :transform_tags
  before_create :get_open_hub_data, if: :open_hub_id

  before_create :create_widgets
  #before_save :update_image_attributes

  attr_accessor :plain_tags
  def image
    avatar
  end
  def image_url
    avatar.url

  end
  def get_open_hub_data
    @open_hub_project = OpenHubProject.find_by_name(self.name)
    self.open_hub_id = @open_hub_project.id

    ohp = open_hub_project
    self.description = ohp.description
    self.remote_avatar_url = ohp.logo_url
    ohp.tags.each {|tag| self.tags << Tag.from_string(tag)}
    self.open_hub_id = ohp.id
  end


  def open_hub_project
    @open_hub_project ||= OpenHubProject.find_by_id(self.open_hub_id) if self.open_hub_id
    @open_hub_project
  end

  def recent?
    created_at > 2.day.ago
  end

  def dismiss_request_ownership(user)
    pendent_owners.delete(user)
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
  def pendent_ownership_requests
    ownership_requests.where(approved:nil)
  end
  def owner?(user)
    self.owners.include?(user)
  end
  
  def add_owner(user)
    owners << user unless owner?(user)

  end
  def remove_owner(user)
    owners.delete(user) if owner?(user)
  end

  def self.search(search)
    if search
      query = "projects.name LIKE ? OR projects.description LIKE ? OR tags.name LIKE ?"
      results = includes(:tags).where(query, "%#{search}%","%#{search}%", "%#{search}%").references(:tags)
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
    self.widgets << WidgetFactory.for(:default_widgets, open_hub_data: open_hub_project)
  end
=begin
  def update_image_attributes
    if image.present?
      self.image_content_type = image.file.content_type 
      self.image_file_size = image.file.size
    end

  end
=end

end
