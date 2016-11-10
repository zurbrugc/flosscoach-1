class Widget < ActiveRecord::Base
  after_initialize :set_defaults, unless: :persisted?

  validates_presence_of :title
  validates_presence_of :tab #tab-slug?
  validates_presence_of :pos_x
  validates_presence_of :pos_y
  validates_presence_of :width
  validates_presence_of :height
  validates_presence_of :content

  belongs_to :project

  scope :from_tab_about, -> {where("tab= ?", "about")}
  scope :from_tab_how_to_start, -> {where("tab= ?", "how_to_start")}
  scope :from_tab_configure_workspace, -> {where("tab= ?", "configure_workspace")}
  scope :from_tab_know_the_code, -> {where("tab= ?", "know_the_code")}
  scope :from_tab_send_contribution, -> {where("tab= ?", "send_contribution")}

  def set_defaults
    self.closeable =  false
    self.resizeable =  true
    self.retractable = true
  end

end
