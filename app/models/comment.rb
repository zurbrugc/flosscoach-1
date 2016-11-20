class Comment < ActiveRecord::Base

	has_many :replies, class_name: "Comment", foreign_key: "reply_to_id"
  	belongs_to :reply_to, class_name: "Comment"
  	belongs_to :widget
	belongs_to :user 
  	before_save :set_widget_from_dad

  	validates_presence_of :content
  	
	scope :is_not_reply, -> { where(reply_to_id: nil) }

	private 
	def set_widget_from_dad
		if reply_to 
			self.widget ||= self.reply_to.widget
		end
	end
end
