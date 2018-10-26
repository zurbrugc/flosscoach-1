class WidgetFactory
  TYPES = {
    default_widget: DefaultWidget,
    opinion_widget: OpinionWidget
  }
  def self.for(type, open_hub_data: nil )
    factory = WidgetFactory.new
    factory.for(type, open_hub_data: open_hub_data)
  end

  def for(type, open_hub_data: nil)
    if type == :default_widgets
      build_default_widgets(open_hub_data: open_hub_data)
    else
      #TODO: build_widget(type, attributes)
    end
  end

  def build_default_widgets(open_hub_data: nil)
    widgets = []
    content = open_hub_data.iframe_html if open_hub_data
    widgets << self.build_widget(:default_widget, "About the project", tab: :about, x: 0, y: 0, width: 6, height: 5, content: content)

    content = open_hub_data.iframe_languages_html if open_hub_data
    widgets << self.build_widget(:default_widget,"Technical skills required", tab: :about, x: 6, y: 0, width: 6, height: 5, content: content )

    content = open_hub_data.links_html if open_hub_data
    widgets << self.build_widget(:default_widget,"Resources avaiable", tab: :about, x: 0, y: 5, width: 6, height: 5, content: content)
    widgets << self.build_widget(:default_widget,"Soft skills required", tab: :about, x: 6, y: 5, width: 6, height: 5)
    widgets << self.build_widget(:default_widget,"Easy tasks", tab: :choosing_a_task_to_start_with, x: 0, y: 0, width: 12, height: 5)


    widgets << self.build_widget(:default_widget,"Finding Mentorship and Support", tab: :find_a_mentor, x: 0, y: 0, width: 12, height: 5)

    widgets << self.build_widget(:default_widget,"Searching the mailing list", tab: :search_before_ask, x: 0, y: 0, width: 6, height: 4)
    widgets << self.build_widget(:default_widget,"Search project site", tab: :search_before_ask, x: 6, y: 0, width: 6, height: 4)

    widgets << self.build_widget(:default_widget,"Synchronous help", tab: :synchronous_chat, x: 0, y: 0, width: 12, height: 4)

    widgets << self.build_widget(:default_widget,"Subscribing to mailing list", tab: :mailing_lists, x: 0, y: 0, width: 6, height: 4)
    widgets << self.build_widget(:default_widget,"Information about mailing list", tab: :mailing_lists, x: 6, y: 0, width: 6, height: 4)

    widgets << self.build_widget(:default_widget,"Resources provided by the project", tab: :setup_your_workspace, x: 0, y: 0, width: 6, height: 4)
    widgets << self.build_widget(:default_widget,"Search for solutions in the mailing list", tab: :setup_your_workspace, x: 6, y: 0, width: 6, height: 4)

    widgets << self.build_widget(:default_widget,"Code documentation", tab: :deal_with_the_code, x: 0, y: 0, width: 6, height: 4)
    widgets << self.build_widget(:default_widget,"Searchable resources", tab: :deal_with_the_code, x: 6, y: 0, width: 6, height: 4)

    widgets << self.build_widget(:default_widget,"Submitting your contribution", tab: :submit_your_changes, x: 0, y: 0, width: 12, height: 4)
    widgets << self.build_widget(:opinion_widget, "Opinion by the others newcomes", tab: :about, x: 0, y: 11, width: 12, height: 5, editable: false, deletable: false)

    widgets << self.build_widget(:default_widget,"Success stories on this project", tab: :success_stories, x: 0, y: 0, width: 12, height: 4)
    widgets
  end

  def build_widget(type, title, slug: nil , tab:, x:, y:, width:, height:, editable: true, deletable: false, content: nil)
    widget = (TYPES[type] || DefaultWidget).new
    widget.title = title
    widget.slug = slug || title.parameterize
    widget.tab = tab
    widget.pos_x = x
    widget.pos_y = y
    widget.width = width
    widget.height = height
    widget.content = content
    widget.deletable = deletable
    widget.editable = editable
    widget
  end





end
