class OpenHubData < ApplicationRecord
  validates_presence_of :open_hub_id
  belongs_to :project
  has_and_belongs_to_many :tags, -> { distinct }

  def self.build(open_hub_project)
    
  end
end
