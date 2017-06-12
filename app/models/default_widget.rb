class DefaultWidget < Widget
  def self.build(title, slug: nil , tab:, x:, y:, width:, height:, editable: true, deletable: false)
    widget = DefaultWidget.new
    widget.title = title
    widget.slug = slug || title.parameterize
    widget.tab = tab
    widget.pos_x = x
    widget.pos_y = y
    widget.width = width
    widget.height = height
    widget.content = "Fill with content."
    widget.deletable = deletable
    widget.editable = editable
    widget
  end

  def self.generate_all
    widgets = []
    widgets << DefaultWidget.build("About the project", tab: :about, x: 0, y: 0, width: 6, height: 5)
    widgets << DefaultWidget.build("Technical skills required", tab: :about, x: 6, y: 0, width: 6, height: 5)
    widgets << DefaultWidget.build("Resources avaiable", tab: :about, x: 0, y: 5, width: 6, height: 5)
    widgets << DefaultWidget.build("Soft skills required", tab: :about, x: 6, y: 5, width: 6, height: 5)

    widgets << DefaultWidget.build("Easy tasks", tab: :choosing_a_task_to_start_with, x: 0, y: 0, width: 12, height: 5)

    widgets << DefaultWidget.build("Finding Mentorship and Support", tab: :find_a_mentor, x: 0, y: 0, width: 12, height: 5)

    widgets << DefaultWidget.build("Searching the mailing list", tab: :search_before_ask, x: 0, y: 0, width: 6, height: 4)
    widgets << DefaultWidget.build("Search project site", tab: :search_before_ask, x: 6, y: 0, width: 6, height: 4)

    widgets << DefaultWidget.build("Synchronous help", tab: :synchronous_chat, x: 0, y: 0, width: 12, height: 4)

    widgets << DefaultWidget.build("Subscribing to mailing list", tab: :mailing_lists, x: 0, y: 0, width: 6, height: 4)
    widgets << DefaultWidget.build("Information about mailing list", tab: :mailing_lists, x: 6, y: 0, width: 6, height: 4)

    widgets << DefaultWidget.build("Resources provided by the project", tab: :setup_your_workspace, x: 0, y: 0, width: 6, height: 4)
    widgets << DefaultWidget.build("Search for solutions in the mailing list", tab: :setup_your_workspace, x: 6, y: 0, width: 6, height: 4)

    widgets << DefaultWidget.build("Code documentation", tab: :deal_with_the_code, x: 0, y: 0, width: 6, height: 4)
    widgets << DefaultWidget.build("Searchable resources", tab: :deal_with_the_code, x: 6, y: 0, width: 6, height: 4)

    widgets << DefaultWidget.build("Submitting your contribution", tab: :submit_your_changes, x: 0, y: 0, width: 12, height: 4)

    widgets
  end
  def to_partial_path
     'widgets/widget'
   end

end
