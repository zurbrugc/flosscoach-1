class Widget < ApplicationRecord


  after_initialize :set_defaults, unless: :persisted?

  validates_presence_of :title
  validates_presence_of :tab #tab-slug?
  validates_presence_of :pos_x
  validates_presence_of :pos_y
  validates_presence_of :width
  validates_presence_of :height
  validates_presence_of :content

  belongs_to :project
  scope :from_tab, -> (tab) {where("tab= ?", tab.to_s)}


  has_many :comments, :dependent => :destroy
  before_create :create_slug

  before_create :set_defaults

  def self.defaults
    widgets = []
    widgets << Widget.build("About the project", tab: :about, x: 0, y: 0, width: 6, height: 5)
    widgets << Widget.build("Technical skills required", tab: :about, x: 6, y: 0, width: 6, height: 5)
    widgets << Widget.build("Resources avaiable", tab: :about, x: 0, y: 5, width: 6, height: 5)
    widgets << Widget.build("Soft skills required", tab: :about, x: 6, y: 5, width: 6, height: 5)

    widgets << Widget.build("Easy tasks", tab: :choosing_a_task_to_start_with, x: 0, y: 0, width: 12, height: 5)

    widgets << Widget.build("Finding Mentorship and Support", tab: :find_a_mentor, x: 0, y: 0, width: 12, height: 5)

    widgets << Widget.build("Searching the mailing list", tab: :search_before_ask, x: 0, y: 0, width: 6, height: 4)
    widgets << Widget.build("Search project site", tab: :search_before_ask, x: 6, y: 0, width: 6, height: 4)

    widgets << Widget.build("Synchronous help", tab: :synchronous_chat, x: 0, y: 0, width: 12, height: 4)

    widgets << Widget.build("Subscribing to mailing list", tab: :mailing_lists, x: 0, y: 0, width: 6, height: 4)
    widgets << Widget.build("Information about mailing list", tab: :mailing_lists, x: 6, y: 0, width: 6, height: 4)

    widgets << Widget.build("Resources provided by the project", tab: :setup_your_workspace, x: 0, y: 0, width: 6, height: 4)
    widgets << Widget.build("Search for solutions in the mailing list", tab: :setup_your_workspace, x: 6, y: 0, width: 6, height: 4)

    widgets << Widget.build("Code documentation", tab: :deal_with_the_code, x: 0, y: 0, width: 6, height: 4)
    widgets << Widget.build("Searchable resources", tab: :deal_with_the_code, x: 6, y: 0, width: 6, height: 4)

    widgets << Widget.build("Submitting your contribution", tab: :submit_your_changes, x: 0, y: 0, width: 12, height: 4)

    widgets

  end

  def self.build(title, slug: nil , tab:, x:, y:, width:, height:)
    widget = Widget.new
    widget.title = title
    widget.slug = slug || title.parameterize
    widget.tab = tab
    widget.pos_x = x
    widget.pos_y = y
    widget.width = width
    widget.height = height
    widget.content = "Fill with content."
    widget.deletable =  false
    widget
  end

  private

  def set_defaults
    self.resizeable ||=  true
    self.retractable ||= false
  end


  def create_slug
    self.slug ||= self.title.parameterize
  end

end
