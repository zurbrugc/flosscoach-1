require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @project = create(:project)
    @forum = @project.forum
    @user = create(:user)
  end

  test "create a topic on a forum" do
    topic = create(:topic, forum: @forum, user: @user)
    assert_equal topic.project, @project
    assert_equal topic.forum, @forum
  end

  test "topic have 0 messages/answers on create" do
    topic = create(:topic, forum: @forum, user: @user)
    assert_equal 0, topic.messages_count
  end

  test "define tags to topic" do
    topic = create(:topic, forum: @forum, user: @user)
    topic.tags << "batata"
    topic.tags << "suco"
    topic.tags << "heroku"
    assert topic.save

    tags = topic.tags
    assert_equal 3, tags.count
    assert_equal "batata", tags[0]
    assert_equal "suco", tags[1]
    assert_equal "heroku", tags[2]
  end

  test "create a topic without a forum" do
    topic = build(:topic, forum: nil)
    assert_not topic.save
  end
  test "create a topic without a user" do
    topic = build(:topic, user: nil)
    assert_not topic.save
  end
  test "insert repeated tags" do
    topic = create(:topic, forum: @forum, user: @user)
    topic.tags << "batata"
    assert topic.save
    topic.tags << "batata"
    assert_not topic.save
  end

  test "delete tags" do
    topic = create(:topic, forum: @forum, user: @user)
    topic.tags << "batata"
    assert topic.save
    topic.tags.delete("batata")
    topic.save
    assert topic.tags.empty?
    assert_equal 0, topic.tags.count
  end


end
