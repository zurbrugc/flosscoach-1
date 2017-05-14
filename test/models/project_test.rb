require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test "create two project with same name" do
    project_one = create(:project, name: "Potato")
    project_two = build(:project, name: "Potato")

    assert_not project_two.save
  end

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

  test "project search" do

    banana = build(:project, name: "Banana")
    assert banana.save
    melao =  build(:project, name: "Melao")
    assert melao.save
    melancia =  build(:project, name: "Melancia")
    assert melancia.save
    melancia2 =  build(:project, name: "Melancia Two")
    assert melancia2.save

    assert_equal banana, Project.search("Banana").first
    assert_equal banana, Project.search("Ban").first

    assert_equal melao, Project.search("Melao").first
    assert_equal melao, Project.search("Mel").first

    assert_equal 2, Project.search("Melancia").count
    assert_equal melancia, Project.search("Melancia").first
    assert_equal melancia2, Project.search("Melancia").last
  end

  test "create a recent project" do
    project = create(:project, created_at: Time.now)
    assert project.recent?

  end
  test "create a no recent project" do
    project = create(:project, created_at: 3.days.ago)
    assert_not project.recent?
  end

end
