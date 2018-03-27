  class User < ApplicationRecord
  include FriendlyId

  friendly_id :username, use: :slugged
  has_secure_password

  validates_presence_of :email
  validates_presence_of :name
  validates_presence_of :username

  validates_uniqueness_of :email

  VALID_EMAIL_FORMAT= /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :email, presence: true, length: {maximum: 260}, format: { with: VALID_EMAIL_FORMAT}, uniqueness: {case_sensitive: false}
  before_save { self.email = email.downcase }

  validates_length_of :password, minimum: 6, :if => :password
  validates_confirmation_of :password, :if => :password
  validates_acceptance_of :terms
  validates :avatar, file_size: { less_than: 3.megabytes }

  before_create :confirmation_token
  #relationships
	has_many :favoriter_projects
	has_many :favorited_projects, through: :favoriter_projects, :source => :project
  has_and_belongs_to_many :projects
  has_many :comments

  mount_uploader :avatar, AvatarUploader
  def photo_url
    unless self.avatar.url.nil?
      self.avatar.url
    else
      "/assets/avatar.jpeg"
    end
  end
  def photo_url_uploaded
      self.photo_url
  end

  def favorite_project(project)
    self.favorited_projects << project
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end
  #TODO: Refactor
  def self.find_or_create_with_omniauth(auth)
    user = self.find_or_create_by(:provider => auth.provider,:uid => auth.uid)
    user.assign_attributes({ name: user.name || auth.info.name,
      email: user.email || auth.info.email || "#{auth.info.name}@flosscoach.com",
      fb_token: auth.credentials.token,
      password: "abababbbb", password_confirmation: "abababbbb"})
    user.username = user.name.parameterize.gsub("-","_")

    user.save!
    if auth.info.image
      user.update_attributes({remote_avatar_url: auth.info.image,
        password: "blablablablabla"})
    end
    user
  end

 def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  private
  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

 # a helper method
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def self.search(search)
    if search
      where("name LIKE ? OR username LIKE ? OR email LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
    else
      all
    end
  end

end
