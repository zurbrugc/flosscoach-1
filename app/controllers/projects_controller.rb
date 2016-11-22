class ProjectsController < ApplicationController
  include WidgetsHelper
  respond_to :html, :js, :json

  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_filter :authorize_project, only: [:new, :create, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:update, :comment]

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
    @project.image_url = ohp ? ohp.medium_logo_url : "/assets/placeholder.png"
    @project.widgets = make_all_widgets(ohp)
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
      widget = @project.widgets.find_by_slug(widget_params[:slug])
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

      widgets << make_widget_technical_skills
      widgets << make_widget_soft_skills
      widgets << make_widget_basic_contribution_flow
      widgets << make_widget_workspace_setup
      widgets << make_widget_resources_provided
      widgets << make_widget_code_documentation
      widgets << make_widget_searchable_resources
      widgets << make_widget_send_contribution

      widgets
    end
      

    #Auto builds for widgets
    def make_widget_about(pre_content = "Fill with text")
      widget = Widget.new
      widget.title = "About"
      widget.slug = "about"
      widget.tab = "about"
      widget.pos_x = 4
      widget.pos_y = 0
      widget.width = 8
      widget.height = 5
      widget.closeable = false
      widget.resizeable = true
      widget.retractable = true
      widget.content = pre_content
      widget
    end

    def make_widget_links(pre_content = "Fill with text")
      widget = Widget.new
      widget.title = "Links"
      widget.slug = "links"
      widget.tab = "about"
      widget.pos_x = 0
      widget.pos_y = 0
      widget.width = 4
      widget.height = 3
      widget.closeable = false
      widget.resizeable = true
      widget.retractable = true
      widget.content = pre_content
      widget
    end

    def make_widget_technical_skills(pre_content = "Fill with text")
      widget = Widget.new
      widget.title = "Technical Skills"
      widget.slug = "technical_skills"
      widget.tab = "how_to_start"
      widget.pos_x = 0
      widget.pos_y = 0
      widget.width = 6
      widget.height = 4
      widget.closeable = false
      widget.resizeable = true
      widget.retractable = true
      widget.content = pre_content
      widget
    end

    def make_widget_soft_skills(pre_content = "Fill with text")
      widget = Widget.new
      widget.title = "Soft skills required"
      widget.slug = "soft_skills"
      widget.tab = "how_to_start"
      widget.pos_x = 6
      widget.pos_y = 0
      widget.width = 6
      widget.height = 4
      widget.closeable = false
      widget.resizeable = true
      widget.retractable = true
      widget.content = pre_content
      widget
    end

    def make_widget_basic_contribution_flow(pre_content = "Fill with text")
      widget = Widget.new
      widget.title = "Basic contribution flow to follow"
      widget.slug = "basic_contribution_flow"
      widget.tab = "how_to_start"
      widget.pos_x = 0
      widget.pos_y = 4
      widget.width = 12
      widget.height = 7
      widget.closeable = false
      widget.resizeable = true
      widget.retractable = true
      widget.content = '<div class="steps steps-vertical">
                    <div class="step done">
                      <span class="step-number">1</span>
                      <div class="step-desc">
                        <span class="step-title">Learn about the project and skills</span>
                        <p>First you need to learn about the project. Search on it and see if it really interests you propose.</p>
                      </div>
                    </div>
                    <div class="step done">
                      <span class="step-number">2</span>
                      <div class="step-desc">
                        <span class="step-title">Setup you local workspace</span>
                        <p>Install the development environment on your machine.</p>
                      </div>
                    </div>

                    <div class="step done">
                      <span class="step-number">3</span>
                      <div class="step-desc">
                        <span class="step-title">Find a task to start with</span>
                        <p>Search a task for beginners to start contributing</p>
                      </div>
                    </div>

                    <div class="step done">
                      <span class="step-number">4</span>
                      <div class="step-desc">
                        <span class="step-title">Study and change the code</span>
                        <p>Dont forget to test your code!</p>
                      </div>
                    </div>
                    <div class="step done">
                      <span class="step-number">5</span>
                      <div class="step-desc">
                        <span class="step-title">Submit your contribution</span>
                        <p>Congratulations, you have successfully contributed to the project.</p>
                      </div>
                    </div>
                    <div class="step error">
                      <div class="step-desc text-center">
                        <span class="step-title text-center">Have a question?</span>
                        <p>Get support from the community.</p>
                      </div>
                    </div>
                  </div>'
      widget
    end

    def make_widget_workspace_setup(pre_content = "Fill with text")
      widget = Widget.new
      widget.title = "Workspace setup"
      widget.slug = "workspace_setup"
      widget.tab = "configure_workspace"
      widget.pos_x = 0
      widget.pos_y = 0
      widget.width = 5
      widget.height = 4
      widget.closeable = false
      widget.resizeable = true
      widget.retractable = true
      widget.content = pre_content
      widget
    end


    def make_widget_resources_provided(pre_content = "Fill with text")
      widget = Widget.new
      widget.title = "Resources provided by project"
      widget.slug = "resources_provided"
      widget.tab = "configure_workspace"
      widget.pos_x = 5
      widget.pos_y = 0
      widget.width = 7
      widget.height = 5
      widget.closeable = false
      widget.resizeable = true
      widget.retractable = true
      widget.content = pre_content
      widget
    end


    def make_widget_code_documentation(pre_content = "Fill with text")
      widget = Widget.new
      widget.title = "Code documentation"
      widget.slug = "code_documentation"
      widget.tab = "know_the_code"
      widget.pos_x = 0
      widget.pos_y = 0
      widget.width = 5
      widget.height = 4
      widget.closeable = false
      widget.resizeable = true
      widget.retractable = true
      widget.content = pre_content
      widget
    end

    def make_widget_searchable_resources(pre_content = "Fill with text")
      widget = Widget.new
      widget.title = "Searcheable resources"
      widget.slug = "searcheable_resources"
      widget.tab = "know_the_code"
      widget.pos_x = 5
      widget.pos_y = 0
      widget.width = 5
      widget.height = 4
      widget.closeable = false
      widget.resizeable = true
      widget.retractable = true
      widget.content = pre_content
      widget
    end

    def make_widget_send_contribution(pre_content = "Fill with text")
      widget = Widget.new
      widget.title = "Submitting yout contribution"
      widget.slug = "send_contribution"
      widget.tab = "send_contribution"
      widget.pos_x = 0
      widget.pos_y = 0
      widget.width = 5
      widget.height = 4
      widget.closeable = false
      widget.resizeable = true
      widget.retractable = true
      widget.content = pre_content
      widget
    end

end