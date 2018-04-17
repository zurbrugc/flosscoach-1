class OwnershipRequest < ApplicationRecord
  belongs_to :user
  belongs_to :project

  scope :pendent, -> { where(approved: nil) }
  scope :declined, -> { where(approved: false) }
  scope :approved, -> { where(approved: true) }

  def approve
    project.add_owner(user)
    project.save
    self.approved = true
    save
  end

  def disapprove
    self.approved = false
    save
  end
end
