class WidgetsController < ApplicationController
  before_action :set_widget, only: [:show, :update, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:update]

  # GET /users
  def index
    @widgets = @project.widgets
  end

  # GET /users/1
  def show
  end

  # POST /users
  def create
    @widget = Widget.new(widget_params)
    if @widget.save
        #format.json { render :json => { :status => 'Ok', :message => 'Received'}, :status => 200 }
        redirect_to @widget.project 
    else
      flash.now[:notice] = @widget.errors.full_messages
      redirect_to @widget.project
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
  def widget_params
    params.require(:widget).permit!
  end

  def set_widget
    @widget = Widget.all.find(params[:id])
  end
end