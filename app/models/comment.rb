class Comment < ActiveRecord::Base
	belongs_to :user
	has_many :replies, class_name: "Comment", foreign_key: "reply_to_id"
  	belongs_to :reply_to, class_name: "Comment"
end
