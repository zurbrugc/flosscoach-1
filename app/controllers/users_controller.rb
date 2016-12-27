class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :edit]
  skip_before_filter :verify_authenticity_token, only: [:update]
  before_action :block_acess, only: [:new]

  # GET /users
  def index
    redirect_to user_path(current_user)
  end

  # GET /users/1
  def show
   @activities_in_your_projects = project_audits(current_user).reverse
   @recent_comments = []

   @recent_activities = current_user.audits.reverse

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.photo_url ||= "/assets/avatar.jpeg"
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      flash[:notice] = "Please confirm your email address to continue"
      redirect_to root_url
      #redirect_to @user
    else
      render :new
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:notice] = "Welcome to the FlossCOACH! Your email has been confirmed.
      Please sign in to continue."
      redirect_to root_url
    else
      flash[:alert] = "Sorry. User does not exist"
      redirect_to root_url
    end
  end
  # PATCH/PUT /users/1

  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end



  private
  def project_audits(user)
    audits = []
    user.projects.each do |project|
      audits += project.audits
      audits += project.associated_audits if project.associated_audits
    end
    audits.sort{|a, b| a.created_at <=> b.created_at}
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = current_user
  end

  def block_acess
    if current_user
      redirect_to root_url
    end
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    #params.require(:user).permit(:photo)
    params.require(:user).permit!.reject{|_, v| v.blank?}
  end


end
