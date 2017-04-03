require 'test_helper'

class TopicsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = create(:project)
    @forum = @project.forum
    #to set current_user in controller
    set_current_user
  end
  test "create new topic" do
    topic = attributes_for(:topic)
    post forum_topics_url(@forum), params: {topic: topic}
    assert_equal 1, @forum.topics.count
    assert_redirected_to @project

    topic = Topic.last
    assert_equal topic.forum, @forum
    assert_equal topic.forum.project, @project
  end

  test "delete a topic" do
    topic = create(:topic, forum: @forum, user: @current_user)
    assert_equal 1, @forum.topics.count
    assert_equal Topic.last, topic
    delete forum_topic_url(@forum, topic)
    assert_equal 0, @forum.topics.count
    assert_redirected_to @project
  end



end
