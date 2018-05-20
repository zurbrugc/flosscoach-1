class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update]
  before_action :set_topic

  # GET /messages
  def index
    @messages = Message.all
  end

  # GET /messages/1
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  def create
    @message = Message.new(message_params)
    @message.user = current_user
    @message.topic = @topic
    if @message.save
      redirect_to [@topic.forum,@topic], notice: 'Message was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      redirect_to [@topic.forum,@topic], notice: 'Message was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /messages/1
  def destroy
    @message = Message.find(params[:message_id])
    @message.destroy
    redirect_to [@topic.forum,@topic], notice: 'Message was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:topic_id])
    end
    def set_message
      @message = Message.where(topic_id: params[:topic_id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:message).permit!
    end
end
