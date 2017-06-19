class Widget < ApplicationRecord
  after_initialize :set_defaults, unless: :persisted?

  validates_presence_of :title
  validates_presence_of :tab #tab-slug?
  validates_presence_of :pos_x
  validates_presence_of :pos_y
  validates_presence_of :width
  validates_presence_of :height

  belongs_to :project
  scope :from_tab, -> (tab) {where("tab= ?", tab.to_s)}

  has_many :comments, :dependent => :destroy
  before_create :create_slug

  before_create :set_defaults
  def self.generate_all
    widgets = DefaultWidget.generate_all
    widgets << OpinionWidget.generate
    widgets
  end


  def tip
    DefaultTip.where(widget_slug: slug) if default?
  end

  def tip?
    !tip.empty?
  end

  def default?
    is_a?(DefaultWidget)
  end
  private

  def set_defaults
    self.resizeable ||=  true
    self.retractable ||= false
  end

  def create_slug
    self.slug ||= self.title.parameterize
  end
  def to_partial_path
     'widgets/widget'
   end
end
