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
      render :show, status: :unauthorized, notice: 'Access unauthorized'
    end
    @codigourl = params[:id]
  end

  # POST /projects
  def create
    @project = Project.new(project_params)
    
    @project.widgets << Widget.defaults
    @project.owners << current_user
    #@project.tags = @project.tags.split(",")
    if !@project.tags.nil?
      @project.tags = @project.tags.split(" ").join(",")
    end

    if @project.save
      @project.get_open_hub_data if params[:openhub_check]
      @project.save
      redirect_to @project, notice: t('Your project was successfully added to Flosscoach')
    else
      #@project.tags = @project.tags.join(",")
      flash.now[:notice] = @project.widgets.first.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  # TODO: Refactor
  def update
    if @project.owner?(current_user)
      if @project.update_attributes(project_params)
        respond_to do |format|
          format.html { render :edit, status: :ok, notice: 'Project was successfully updated.'}
          format.json { render :json => { :status => 'Ok', :message => 'Received'}, :status => :ok }
        end
      else
        respond_to do |format|
          format.html { render :edit, status: :unprocessable_entity, notice: 'Update failed!'}
          format.json { render :json => { :status => 'Error', :message => 'Error on update'}, :status => :unprocessable_entity }
        end
      end
    else
      render :show, status: :unauthorized, notice: 'Access unauthorized'
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project was successfully destroyed.'
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
