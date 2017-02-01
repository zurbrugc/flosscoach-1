class Comment < ApplicationRecord
	audited

	has_many :replies, class_name: "Comment", foreign_key: "reply_to_id"
  	belongs_to :reply_to, class_name: "Comment"
  	belongs_to :widget
	belongs_to :user
  	before_save :set_widget_from_dad

  	validates_presence_of :content
  	delegate :project, to: :widget
	scope :is_not_reply, -> { where(reply_to_id: nil) }
	scope :most_recents, -> { where(created_at: (Time.now - 3.days)..Time.now) }

	private
	def set_widget_from_dad
		if reply_to
			self.widget ||= self.reply_to.widget
		end
	end
end
