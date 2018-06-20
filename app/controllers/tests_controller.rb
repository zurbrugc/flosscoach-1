class TestsController < ApplicationController
 before_action :set_project, only: [:index]
 def index
  good_first_issues(@project.repo_info)
 end

 def good_first_issues(search_param)
    # Provide authentication credentials:
    client = Octokit::Client.new(:access_token => "957b5755c2b1b73b04cff90093c9e2791fb7fb58", per_page: 20)   
    #search for issues in repo passed as argument:
    response = Octokit.list_issues(search_param,{'labels' => "good first issue" })
    
    issues = [[],[]]
    limit = 10
    response.each do |issue|
      break if limit < 1
      issues[0] << issue['title']
      issues[1] << issue['html_url']
      limit -= 1
    end
    @issues = issues[0].zip issues[1]

    if @issues.empty?
      @issues = nil
      return @issues
    else
      return @issues
    end

  end

  private
  def set_project
      @project = Project.find(params[:id])
    end
    
end