class WidgetComment < Comment
  belongs_to :widget
  before_create :set_widget_from_dad
  has_many :comments, class_name: 'WidgetComment'


  def to_partial_path
     'widgets/comments/comment'
   end
  private
	def set_widget_from_dad
		if reply_to
			self.widget ||= self.reply_to.widget
		end
	end
end
