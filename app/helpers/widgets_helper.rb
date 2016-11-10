module WidgetsHelper

  def make_all_widgets(open_hub_project = nil)
    widgets = []
    widgets_name = ["technical_skills", "soft_skills", "basic_contribution_flow", "workspace_setup",
     "resources_provided", "code_documentation", "searcheable_resources", "send_contribution"]

    check_open_hub_project(open_hub_project, widgets)

    widgets_name.each do |name|
      widgets << make_widget(name)
    end

    widgets
  end

  def check_open_hub_project(open_hub_project, widgets)
    if(open_hub_project)
      widgets << make_open_hub_widgets
    else
      widgets << make_widget("links")
      widgets << make_widget("about")
    end
  end

  def read_yml
    config = YAML.load_file('config/widgets_helper.yml')
  end

  def set_widget_values(widget_name)
    widget_values = []
    yml = read_yml
    yml.each do |name, values|
      if name == widget_name
        values.each do |_key, value|
          widget_values << value
        end
      end
    end
    widget_values
  end

  def make_widget(widget_name)
    widget_values = []
    widget_values = set_widget_values(widget_name)

    widget = Widget.new(title: widget_values[0], slug: widget_values[1], tab: widget_values[2],
    pos_x: widget_values[3], pos_y: widget_values[4], width: widget_values[5], height: widget_values[6],
    content: widget_values[7])
  end

  def make_open_hub_widgets
    open_hub_widgets = []
    open_hub_widgets << make_widget("open_hub_about")
    open_hub_widgets << make_widget("open_hub_links")

    open_hub_widgets
  end

end
