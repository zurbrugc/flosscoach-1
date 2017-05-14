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
      render :new, status: :unauthorized, error:  "Invalid e-mail or password."
    end
  end


  # DELETE /sessions/1
  def destroy
    session.delete(:user_id)
    redirect_to sign_in_path, success: 'Session was successfully destroyed.'
  end

  private
  def check_confirmed_email(user)
    if user.email_confirmed?
      session[:user_id] = user.id
      redirect_to projects_path
    else
      render :new, status: :unauthorized, alert: "Please verify your e-mail and confirm your registration."
    end
  end

    # Only allow a trusted parameter "white list" through.
    def session_params
      params.require(:session).permit!
    end
end
