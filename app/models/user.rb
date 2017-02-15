require "bcrypt"
class User < ApplicationRecord
  include FriendlyId

  friendly_id :username, use: :slugged
  audited except: :avatar
  has_associated_audits

  has_and_belongs_to_many :projects

  has_many :comments
  validates_presence_of :email, :name
  validates_format_of :email, :with => /@/
  validates_uniqueness_of :username
  validates_presence_of :password,  :if => :password
  validates_uniqueness_of :email
  validates_length_of :password, minimum: 6, :if => :password
  validates_confirmation_of :password, :if => :password
  validates_acceptance_of :terms

  before_create :confirmation_token

	has_many :favoriter_projects
	has_many :favorited_projects, through: :favoriter_projects, :source => :project
  mount_uploader :avatar, AvatarUploader
  validates :avatar, file_size: { less_than: 3.megabytes }

  def photo_url
    unless avatar.url.nil?
      avatar.url
    else
      "/assets/avatar.jpeg"
    end
  end
  def photo_url_uploaded
      photo_url
  end
  def password=(new_password)
    @password = new_password
    self.encrypted_password = BCrypt::Password.create(@password)
  end
  def password
    @password
  end
  def valid_password?(password_to_validate)
    BCrypt::Password.new(encrypted_password) == password_to_validate
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
      photo_url: user.photo_url || auth.info.image,
      fb_token: auth.credentials.token,
      password: "abababbbb", password_confirmation: "abababbbb"})
    user.save!
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
end
