class LoginController < ApplicationController
  def index
    if current_user
      redirect_to projects_path
    end
  end

  def create
    user = User.find_by_email(params[:user][:email])

    if user && user.valid_password?(params[:user][:password])
      if user.email_confirmed?
        session[:user_id] = user.id
        redirect_to projects_path
      else
        flash.now[:alert] = "Please verify your e-mail and confirm your registration."
        render action: "index"       
      end
      #redirect_to @user
    else
      flash.now[:alert] = "Invalid e-mail or password."
      render action: "index"
    end
  end

  def logout
    session.delete(:user_id)
    render action: "index"
  end

  def search
    @projects = Project.search(params[:query])
    if request.xhr?
      render :json => @projects.to_json
    else
      render :index
    end
  end



end
