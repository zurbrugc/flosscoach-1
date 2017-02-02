require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "create a user with a invalid email" do
    user = build(:user, email: "www.google.com")
    assert_not user.save, "User with invalid email has been saved!"
  end

  test "user creating a project" do
    user = create(:user)
    project = create(:project)
    project.owners << user

    assert_equal 1, project.owners.size, "User project count is different of one"
    assert_equal project, user.projects.first
  end

  test "user removed from administration of a project" do
    user = create(:user)
    project = create(:project)
    project.owners << user
    assert_equal 1, project.owners.size, "User project count is different of one"

    project.owners.delete(user)
    assert_equal 0, project.owners.size, "User project count is different of zero"
    assert_equal 0, user.projects.size
  end

  test "generate slug from username" do
    user = build(:user)
    username = user.username
    user.save

    assert_equal username, user.slug
  end

end
