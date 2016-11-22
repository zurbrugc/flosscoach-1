=begin require 'spec_helper'

describe WidgetsHelper do
  before do
    @config = YAML.load_file('config/widgets_helper.yml')

    @widget_technical_skills = Widget.new(title: "Technical Skills", slug: "technical_skills",
    tab: "how_to_start", pos_x: 0, pos_y: 0, width: 6, height: 4, content: "Fill with text")
    @widget_technical_skills.save

  end

  describe "#read_yml" do
    it "returns a hash according to widgets_helper.yml" do
      expect(helper.read_yml) == @config
    end
  end

  describe "set_widget_values" do
    it "returns an array with all widget values" do
        widget_values = helper.set_widget_values("about")
        expect(widget_values[0]).to eq("About")
        expect(widget_values[1]).to eq("about")
        expect(widget_values[2]).to eq("about")
        expect(widget_values[3]).to eq(4)
        expect(widget_values[4]).to eq(0)
        expect(widget_values[5]).to eq(8)
        expect(widget_values[6]).to eq(5)
        expect(widget_values[7]).to eq("Fill with text")
    end
  end

  describe "#make_widget" do
    it "returns a new widget" do
      widget = helper.make_widget("technical_skills")
      expect(widget) == @widget_technical_skills
    end
  end

  describe "#make_widget_about" do
    it "returns an array with 2 elements" do
      open_hub_widgets = helper.make_open_hub_widgets
      expect(open_hub_widgets.count).to eq(2)
    end
  end

  describe "#check_open_hub_project" do
    it"Open Hub project != nil" do
      widgets = []
      helper.check_open_hub_project("OpenHubProject", widgets)
      expect(widgets.count).to eq(1)
    end

    it"Open Hub project == nil" do
      widgets = []
      helper.check_open_hub_project(nil, widgets)
      expect(widgets.count).to eq(2)
    end
  end

  describe "#make_all_widgets" do
    it "returns an array with all widget" do
      widgets = helper.make_all_widgets(nil)
      expect(widgets.count).to eq(10)
    end
  end
end
=end
