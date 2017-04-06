class LandingPageController < ApplicationController
  before_action :set_landing_page, only: [:show, :edit, :update, :destroy]
  before_action :block_access
  # GET /landing_pages
  def index
    @landing_pages = LandingPage.all
  end

  # GET /landing_pages/1
  def show
  end

  # GET /landing_pages/new
  def new
    @landing_page = LandingPage.new
  end

  # GET /landing_pages/1/edit
  def edit
  end

  # POST /landing_pages
  def create
    @landing_page = LandingPage.new(landing_page_params)

    if @landing_page.save
      redirect_to @landing_page, notice: 'Landing page was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /landing_pages/1
  def update
    if @landing_page.update(landing_page_params)
      redirect_to @landing_page, notice: 'Landing page was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /landing_pages/1
  def destroy
    @landing_page.destroy
    redirect_to landing_pages_url, notice: 'Landing page was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_landing_page
      @landing_page = LandingPage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def landing_page_params
      params.fetch(:landing_page, {})
    end
end
