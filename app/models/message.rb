class Message < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  validates :content, presence: true, allow_blank: false
  validates_presence_of :user
  validates_presence_of :topic

  def empty?
    content.empty?
  end
  def blank?
    content.blank?
  end
  def to_s
    content
  end
end
