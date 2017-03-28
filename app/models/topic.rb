class Topic < ApplicationRecord
  belongs_to :forum
  has_many :messages
  
  def project
    forum.project
  end

  def messages_count
    messages.count
  end
end
