class Forum < ApplicationRecord
  belongs_to :project
  has_many :topics, :dependent => :destroy

  def topics
  	forum.topics
  end
  
  def topics?
    topics.count > 0
  end
end

