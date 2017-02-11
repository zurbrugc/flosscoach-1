require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test "user creating a project" do
    user = create(:user)
    project = create(:project)
    project.owners << user

    assert_equal 1, project.owners.size, "User project count is different of one"
    assert_equal project, user.projects.first
    assert_equal user, project.owners.first
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
end
