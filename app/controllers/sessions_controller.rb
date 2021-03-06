class SessionsController < ApplicationController
  before_action :block_access, except: [:destroy]

  # GET /sessions
  def index
    render :new
  end

  # GET /sessions/new
  def new

  end

  # POST /sessions
  def create
    user = User.find_by_email(session_params[:email])
    if user && user.authenticate(session_params[:password])
      check_confirmed_email(user)
    else
      flash.now[:error] = "Invalid e-mail or password."
      render :new, status: :unauthorized
    end
  end


  # DELETE /sessions/1
  def destroy
    #session.delete(:user_id)
    reset_session
    redirect_to sign_in_path, success: 'You logged out successfully.'
  end

  private
  def check_confirmed_email(user)
    if user.email_confirmed?
      session[:user_id] = user.id
      redirect_to projects_path
    else
      UserMailer.registration_confirmation(user).deliver_now
      flash.now[:alert] = "We resend you an email to confirm your registration."
      render :new, status: :unauthorized
    end
  end

    # Only allow a trusted parameter "white list" through.
    def session_params
      params.require(:session).permit!
    end
end
