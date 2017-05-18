class Topic < ApplicationRecord
  include Taggable

  belongs_to :forum
  has_many :messages

  belongs_to :user
  validates_presence_of :forum
  validates_presence_of :user

  def project
    forum.project
  end

  def messages_count
    messages.count
  end

  def recent?
    created_at > 2.day.ago
  end

end
