  class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :edit]
  skip_before_action :verify_authenticity_token, only: [:update]

  before_action :block_access, only:[:new, :create, :confirm_email]
  before_action :authorize, except: [:new, :create,:show, :confirm_email]
  # GET /users
  def index
    @users = User.search(params[:search])
  end

  # GET /users/1
  def show

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
    if @user.save
      UserMailer.registration_confirmation(@user).deliver_now
      flash[:notice] = "Please confirm your email address bt checking your inbox"
      redirect_to sign_in_path
    else
      flash[:error] = "Something went wrong while registrating you, check for errors and try again"
      render :new
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
        user.email_activate
        flash[:success] = "Welcome to FlossCoach! Your email has been confirmed.
        Sign in to continue, please."
      redirect_to sign_in_path
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to sign_in_path
    end
  end
  # PATCH/PUT /users/1

  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html {
          render :show, status: :ok, notice: 'User was successfully updated.' }
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

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.friendly.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    #params.require(:user).permit(:photo)
    params.require(:user).permit!.reject{|_, v| v.blank?}
  end


end
