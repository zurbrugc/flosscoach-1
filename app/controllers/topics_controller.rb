class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :set_forum_and_project
  before_action :authorize, except: [:show]


  # GET /topics
  def index
    @topics = @project.topics
  end

  # GET /topics/1
  def show

  end


  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  def create
    @topic = Topic.new(topic_params)
    @topic.forum = @forum
    @topic.user = current_user
    if @topic.save
      redirect_to forum_path(@forum.project_id), success: 'Topic was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /topics/1
  def update
    if @topic.update(topic_params)
      
      redirect_to [@topic.forum,@topic], notice: 'Topic was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /topics/1
  def destroy
    @topic.destroy
    redirect_to @forum, notice: 'Topic was successfully destroyed.'
  end

    
  private
    # Use callbacks to share common setup or constraints between actions.
    #now is set propely
    def set_forum_and_project
      @forum = Forum.find(params[:forum_id])
      @project = @forum.project
    end

    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def topic_params
      params.require(:topic).permit!
    end
end
