require 'test_helper'

class OpenHubProjectTest < ActiveSupport::TestCase
  test "find firefox project by name" do
    project =  OpenHubProject.find_by_name("Firefox")
    assert_equal "Mozilla Firefox", project.name
    #assert_equal "http://www.firefox.com/", project.homepage_url
    assert_equal "https://www.mozilla.org/en-US/firefox/", project.homepage_url
  end

  test "find firefox project by id" do
    project =  OpenHubProject.find_by_id(9) #9 is the ID of Firefox Project on OpenHub
    assert_equal "Mozilla Firefox", project.name
    #assert_equal "http://www.firefox.com/", project.homepage_url
    assert_equal "https://www.mozilla.org/en-US/firefox/", project.homepage_url
  end
end
