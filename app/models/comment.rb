class Comment < ApplicationRecord
  #transform this in a abstract class?
	has_many :replies, class_name: "Comment", foreign_key: "reply_to_id"
  belongs_to :reply_to, class_name: "Comment"
	belongs_to :user

  validates_presence_of :content

	scope :is_not_reply, -> { where(reply_to_id: nil) }
	scope :except_replies, -> { where(reply_to_id: nil) }

	scope :most_recents, -> { where(created_at: (Time.now - 3.days)..Time.now) }
end
