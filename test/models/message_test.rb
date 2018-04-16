require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @project = create(:project)
    @forum = @project.forum
    @topic = create(:topic, forum: @forum)
    @user = create(:user)
  end

  test "post a message on topic" do
    message = create(:message, user: @user, topic: @topic)
    assert_not message.nil?
    assert_not message.empty?
    assert message.persisted?
    assert_equal @user, message.user
    assert_equal @topic, message.topic
    assert_equal 1, @topic.messages.count
  end
  test "post a message on topic 2" do
    message = create(:message, content: "Batata :D", user: @user, topic: @topic)
    assert_not message.nil?
    assert_not message.empty?
    assert message.persisted?
    assert_equal "Batata :D", message.content
    assert_equal "Batata :D", message.to_s
    assert_equal 1, @topic.messages_count
  end
  test "create a message without a user" do
    message = build(:message, user: nil, topic: @topic)
    assert_not message.save
  end

  test "create a blank message" do
    message = build(:message, content: "", user: @user, topic: @topic)
    assert message.empty?
    assert_not message.save, "Saved a empty message."
    message = build(:message, content: "          ", user: @user, topic: @topic)
    assert message.blank?, "Saved a blank message."
    assert_not message.save
  end

end
