class OmniAuthLoginController < ApplicationController
  before_action :block_access
  def index
    if current_user
      redirect_to projects_path
    end
  end

  def create
    auth = auth_hash
    user = User.find_or_create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to projects_path

  end

  def failure
    redirect_to root_url
  end

  def destroy
=begin
    reset_session 
    redirect_to request.referer
    session.delete(:user_id)
    render action: "index"
=end
  end

  protected
  def auth_hash
    request.env['omniauth.auth']    
  end
end
