class ProjectsController < ApplicationController
  respond_to :html, :js, :json
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:update]
  before_action :authorize, except: [:index, :show]

  # GET /projects
  def index
    @projects = Project.search(params[:search])
 	  @project = Project.new
    @order_by ||= "Recents"
  end

  # GET /projects/1
  def show

  end

  # GET /projects/new
  def new
    @project = Project.new
  end
  def recent
    @projects = Project.search(params[:search])
    @project = Project.new
    @order_by = "Recents"

    render :index
  end

  def most_favorited
    @projects = Project.all.search(params[:search])
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

  # POST /projects
  def create
    @project = Project.new(project_params)
    @project.owners << current_user
    @project.get_open_hub_data if params[:openhub_check]
    
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
        respond_to do |format|
          format.html { render :edit, status: :ok, success: 'Project was successfully updated.'}
          format.json { render :json => { :status => 'Ok', :message => 'Received'}, :status => :ok }
        end
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.includes(:widgets).find(params[:id])
      @project.forum ||= Forum.new
      @project.save
      @forum = @project.forum
      #@project = current_user.projects.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.


    def project_params
      params.require(:project).permit!
    end
end
