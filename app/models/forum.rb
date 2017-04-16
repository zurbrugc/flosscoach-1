class Forum < ApplicationRecord
  belongs_to :project
  has_many :topics

  def topics?
    topics.count > 0
  end
end
