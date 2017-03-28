require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "post a message on topic" do
    project = create(:project)
    forum = project.forum
    topic = create(:topic, forum: forum)
    user = create(:user)
    message = create(:message, user: user, topic: topic)
    assert_not message.nil?
    assert_not message.empty?
    assert message.persisted?
    assert_equal user, message.user
    assert_equal topic, message.topic
    assert_equal 1, topic.messages_count
  end
  test "post a message on topic 2" do
    project = create(:project)
    forum = project.forum
    topic = create(:topic, forum: forum)
    user = create(:user)
    message = create(:message, content: "Batata :D", user: user, topic: topic)
    assert_not message.nil?
    assert_not message.empty?
    assert message.persisted?
    assert_equal "Batata :D", message.content
    assert_equal "Batata :D", message.to_s
    assert_equal 1, topic.messages_count
  end
  test "create a message without a user" do
    project = create(:project)
    forum = project.forum
    topic = create(:topic, forum: forum)
    message = build(:message, user: nil, topic: topic)
    assert_not message.save
  end

  test "create a blank message" do
    project = create(:project)
    forum = project.forum
    topic = create(:topic, forum: forum)
    user = create(:user)
    message = build(:message, content: "", user: user, topic: topic)
    assert message.empty?
    assert_not message.save
    message = build(:message, content: "                   ", user: user, topic: topic)
    assert message.blank?
    assert_not message.save
  end

end
