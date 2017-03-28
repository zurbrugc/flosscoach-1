require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "create a topic on a forum" do
    project = create(:project)
    forum = project.forum
    topic = create(:topic, forum: forum)
    assert_equal topic.project, project
    assert_equal topic.forum, forum
  end

  test "topic have 0 messages/answers on create" do
    project = create(:project)
    forum = project.forum
    topic = create(:topic, forum: forum)
    assert_equal 0, topic.messages_count
  end
end
