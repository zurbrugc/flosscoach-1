class ProjectsController < ApplicationController
  include WidgetsHelper
  respond_to :html, :js, :json

  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_filter :authorize_project, only: [:new, :create, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:update, :comment]

  # GET /projects
  def index
    @projects = Project.all.search(params[:search])
 	@myproject = Project.new	
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
    @project.image_url = "/assets/placeholder.png"
    if ohp && ohp.try(:medium_logo_url)
      @project.image_url = ohp.medium_logo_url
    end
    @project.widgets << make_all_widgets(ohp)
    @project.owners << current_user
    if @project.save
      redirect_to edit_project_path(@project), notice: t('Project was successfully created.')
    else
      flash.now[:notice] = @project.widgets.first.errors.full_messages
      render :new
    end
  end

  # PATCH/PUT /projects/1
  # TODO: Refactor
  def update
    if(params[:widget])
      widget = @project.widgets.find_by_id(widget_params[:id])
      widget.update_attributes(widget_params)
    elsif @project.update_attributes(project_params)
      #redirect_to @project, notice: 'Project was successfully updated.'
      respond_to do |format|
        format.json { render :json => { :status => 'Ok', :message => 'Received'}, :status => 200 }
      end
    else
    #  render :edit
    end
  end
  
  def comment
    comment = Comment.new(comment_params)
    comment.user = current_user
    if comment_params[:widget_id]
      @widget = Widget.find(comment_params[:widget_id])
      @widget.comments << comment
      comment.widget = @widget
    elsif comment_params[:reply_to_id]
      comment_dad = Comment.find(comment_params[:reply_to_id])
      comment_dad.replies << comment
      @widget = comment_dad.widget
    end
    respond_to do |format|
    if comment.save
      flash.now[:notice] = "Comment was successfully saved."
        format.js
        format.html
      end
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
      #@project = current_user.projects.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.

    def comment_params
      params.permit(:content, :widget_id, :reply_to_id)
    end

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
