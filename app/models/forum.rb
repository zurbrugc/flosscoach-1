class Forum < ApplicationRecord
  belongs_to :project
  has_many :topics
end
