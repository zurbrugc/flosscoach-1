require 'test_helper'

class WidgetTest < ActiveSupport::TestCase
  test "default widgets" do
    project = create(:project)
    assert project.widgets.count > 0
    assert project.widgets.all? {|widget| widget.default?}
  end
end
