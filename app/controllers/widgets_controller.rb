class WidgetsController < ApplicationController
  before_action :set_widget, only: [:show, :update, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:update]

  def index
    @widgets = @project.widgets
  end

  def show
    redirect_to @widget.project
  end

  def create
    @widget = Widget.new(widget_params)
    @project = @widget.project
    @widget.closeable = true
    if @widget.save
        #format.json { render :json => { :status => 'Ok', :message => 'Received'}, :status => 200 }
        redirect_to @project
    else
      flash.now[:notice] = @widget.errors.full_messages
      redirect_to @project
    end
  end

  def update
    if @widget.update_attributes(widget_params)
      respond_to do |format|
        format.json { render :json => { :status => 'Ok', :message => 'Received'}, :status => 200 }
        format.html { redirect_to @project }
      end
    else
      render :edit
    end
  end

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
    @project = @widget.project
  end


end
