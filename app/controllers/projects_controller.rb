class ProjectsController < ApplicationController
  include WidgetsHelper

  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_filter :authorize_project, only: [:new, :create, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:update]

  # GET /projects
  def index
    @projects = Project.all.search(params[:search])
    if current_user
      @myproject = current_user.projects.build
    else
      @myproject = Project.all.search("nenhum")
    end
  end

  # GET /projects/1
  def show
    @codigourl = params[:id]
    @language = Language.where(:id => @project.language_id).first
    @tool = Tool.where(:id => @project.tool_id).first
  end

  # GET /projects/new
  def new
    @project = current_user.projects.build
    @languages = Language.all
    @tools = Tool.all
    @operatingsystems = OperatingSystem.all
  end

  # GET /projects/1/edit
  def edit
    @codigourl = params[:id]
    @language = Language.where(:id => @project.language_id).first
    @tool = Tool.where(:id => @project.tool_id).first
  end

  # POST /projects
  def create
    @project = Project.new(project_params)
    ohp = OpenHubProject.find_by_name(@project.name).first if params[:openhub_check]
    @project.image_url = ohp.medium_logo_url if ohp else "/assets/placeholder.png"
    @project.widgets = make_all_widgets(ohp)
    @project.owners << current_user
    if @project.save
      redirect_to @project, notice: t('Project was successfully created.')
    else
      flash.now[:notice] = @project.widgets.first.errors.full_messages
      render :new
    end
  end

  # PATCH/PUT /projects/1
  def update
    if(params[:widget])
      widget = @project.widgets.find_by_slug(widget_params[:slug])
      widget.update_attributes(widget_params)
    elsif @project.update_attributes(project_params)
      #redirect_to @project, notice: 'Project was successfully updated.'
      respond_to do |format|
        # @project.image_url = @project.image_project.url
        @project.image_url = /(\/*\/*\/*\/*\/*\/*\/*[[:alnum:]]|_|-|\.|jpg|jpeg|gif)*/.match(@project.image_project.url)
        @project.save
        format.html {redirect_to @project, notice: 'Project successfully updated'}
        format.json { render :json => { :status => 'Ok', :message => 'Received'}, :status => 200 }
    end
    else
    #  render :edit
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project was successfully destroyed.'
  end

  # User can favorite or unfavorite a project
  def favorite
    favorite_project = FavoriteProject.create_favorite_project(current_user.id, params[:id])
    redirect_to :back
  end

  def unfavorite
    favorite_project = FavoriteProject.find_by(user_id: current_user.id, project_id: params[:id])
    favorite_project.destroy
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.all.find(params[:id])
      #@project = current_user.projects.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def project_params
      params.require(:project).permit!
    end

    def widget_params
      params.require(:widget).permit!
    end

    def authorize_project
      unless current_user
        redirect_to root_path, alert: t('You need to login to continue.')
      end
    end

end
