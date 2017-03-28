require 'test_helper'

class ForumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "creating a project, automagically creates a forum" do
    project = create(:project)
    assert_not project.forum.nil?
  end
end
