class ProjectsController < ApplicationController
  include WidgetsHelper
  respond_to :html, :js, :json

  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authorize_project, only: [:new, :create, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:update]

  # GET /projects
  def index
    @projects = Project.all.search(params[:search])
 	  @project = Project.new
  end

  # GET /projects/1
  def show

  end

  # GET /projects/new
  def new
    @project = current_user.projects.build
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
    ohp = OpenHubProject.find_by_name(@project.name).first if params[:openhub_check]
    if ohp && ohp.try(:medium_logo_url)
      @project.open_hub_image_url = ohp.medium_logo_url
      @project.use_open_hub_data = true
      @project.use_open_hub_image = true
    end
    @project.widgets << make_all_widgets(ohp)
    @project.owners << current_user
    if @project.save
      redirect_to project_path(@project), notice: t('Project was successfully created.')
    else
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
      @project = Project.all.find(params[:id])
      @project.forum ||= Forum.new
      @project.save
      @forum = @project.forum
      #@project = current_user.projects.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.


    def project_params
      params.require(:project).permit!
    end

    def authorize_project
      unless current_user
        redirect_to root_path, alert: t('You need to login to continue.')
      end


    end



end
