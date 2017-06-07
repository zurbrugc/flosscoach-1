class ProjectComment < Comment
  belongs_to :project
  before_create :set_project_from_dad

  private
	def set_project_from_dad
		if reply_to
			self.project ||= self.reply_to.project
		end
	end
end
