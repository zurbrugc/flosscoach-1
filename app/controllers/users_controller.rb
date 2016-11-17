class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :edit]
  skip_before_filter :verify_authenticity_token, only: [:update]


  # GET /users
  def index
    redirect_to user_path(current_user)
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
    @user.photo_url ||= "/assets/avatar.jpeg"
    if @user.save
      flash[:notice] = "Please confirm your email address to continue"
      redirect_to root_url
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
      if @user.update(user_params)
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


  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = current_user
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit!
  end

end
