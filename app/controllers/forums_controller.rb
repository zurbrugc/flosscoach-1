class ForumsController < ApplicationController
  before_action :set_forum, only: [:edit, :update, :destroy]
  before_action :set_project, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :authorize, except: [:show]
  before_action :set_topics, only: [:show]
  # GET /forums
  def index
    @forums = Forum.all
  end



  # GET /forums/1
  def show
    #set_topics_and_project
  end

  # GET /forums/new
  #isso cria um formulário para um novo projeto
  def new
    @forum = Forum.new
  end

  # GET /forums/1/edit
  def edit
  end

  # POST /forums
  def create
    forum = Forum.new(forum_params)
    forum.project_id = params[:project_id]
    if forum.save
      redirect_to forum_path(forum.project_id), notice: 'Forum was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /forums/1
  def update
    if @forum.update(forum_params)
      redirect_to @forum, notice: 'Forum was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /forums/1
  def destroy
    @forum.destroy
    redirect_to forums_url, notice: 'The forum was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forum
      #.where() method return an array of active relations
      @forum = Forum.where(project_id: params[:project_id])[0]
    end

    def set_project
      #@project = Project.includes(:widgets).find(params[:format] || params[:project_id])
      #this line once was lke the above, if you have any trouble come back to it:
      @project = Project.includes(:widgets).find(params[:id] || params[:project_id])
    end

    
    def set_topics
      @forum = Forum.where(project_id: params[:id])[0]
      # .where() method return an ARRAY of active relations
      @topics = Topic.where(forum_id: @forum.id)
    end

    # Only allow a trusted parameter "white list" through.
    def forum_params
      params.fetch(:forum, {})
    end
end
