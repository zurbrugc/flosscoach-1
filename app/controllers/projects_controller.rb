class ProjectsController < ApplicationController
  before_action :set_project
  respond_to :html, :js, :json
  skip_before_action :verify_authenticity_token, only: [:update]
  before_action :authorize, except: [:index, :show]
  skip_before_action :set_project, only: [:index]
  # GET /projects
  def index
    @projects = Project.search(params[:search])
 	  @project = Project.new
    @order_by ||= "Recents"
  end

  # GET /projects/1
  def show
    github_issues
  end

  #placebo actions for tabs:
  def test
    github_issues
  end
  def start
    github_issues
  end

  def community
    github_issues
  end

  def workspace
    github_issues
  end

  def code
    github_issues
  end

  def changes
    github_issues
  end
  
  #end of actions for tabs




  # GET /projects/new
  def new
    @project = Project.new
  end
  
  def recent
    @projects = Project.active.search(params[:search])
    @project = Project.new
    @order_by = "Recents"

    render :index
  end

  def most_favorited
    @projects = Project.active.search(params[:search])
    @project = Project.new
    @order_by ||= "Most favorited"

    render :index

  end
  # GET /projects/1/edit
  def edit
    unless @project.owner?(current_user)
      render :show, status: :unauthorized, error: 'Access unauthorized'
    end
    @codigourl = params[:id]
  end

  #TODO: Refactor and create a Open Hub Controller
  def similiar_open_hub_projects
    projects = OpenHubProject.find_by_name(params[:project_name], list:true)
    if projects.empty?
      render json: nil, status: :unprocessable_entity
    else
      render json: OpenHubProject.find_by_name(params[:project_name], list:true), status: :ok
    end
  end

  # POST /projects
  def create
    @project = Project.new(project_params)
    @project.owners << current_user
    @project.primary_owner = current_user.id
    @project.status = "active"
    if @project.save
      redirect_to @project, success: 'Project was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  # TODO: Refactor
  def update
    if @project.owner?(current_user)
      if @project.update_attributes(project_params)
        redirect_to @project, notice: "You edited your project with success!"
      
      else
        respond_to do |format|
          format.html { render :edit, status: :unprocessable_entity, error: 'Update failed!'}
          format.json { render :json => { :status => 'Error', :message => 'Error on update'}, :status => :unprocessable_entity }
        end
      end
    else
      render :show, status: :unauthorized, error: 'Access unauthorized!'
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
    redirect_to projects_url, success: 'Project was successfully destroyed.'
  end


  #accessing github API, and requesting issues of a project:
  def github_issues
    search_param = @project.repo_info
    if !search_param.blank?
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
    return false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.includes(:widgets).find(params[:id] || params[:project_id])
    end

    # Only allow a trusted parameter "white list" through.


    def project_params
      params.require(:project).permit!
    end
end
