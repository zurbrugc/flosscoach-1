class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]
  before_action :set_widget, only: [:show, :update, :destroy, :create]
  skip_before_filter :verify_authenticity_token, only: [:update]
  before_action :authorize

  # GET /users
  def index
    if params[:without_replies]
      @comments = @widget.comments.is_not_replies
    else
      @comments = @widget.comments
    end
  end

  # GET /users/1
  def show
    redirect_to comment.widget.project
  end

  # POST /users
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.widget = @widget
    @widget.comments << @comment

    if comment_params[:reply_to_id]
      comment_dad = Comment.find(comment_params[:reply_to_id])
      comment_dad.replies << @comment
    end

    respond_to do |format|
    if @comment.save
      flash.now[:notice] = "Comment was successfully saved."
        format.js
        format.html
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    if @widget.update_attributes(widget_params)
      respond_to do |format|
        format.json { render :json => { :status => 'Ok', :message => 'Received'}, :status => 200 }
      end
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @widget.destroy
    redirect_to @project, notice: 'Widget was successfully destroyed.'
  end

  private


  # Only allow a trusted parameter "white list" through.
  def comment_params
    params.require(:comment).permit!
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
  def set_widget
    @widget = Widget.find(params[:widget_id])
  end



end
