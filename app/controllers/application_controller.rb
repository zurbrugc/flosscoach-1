class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  private
  def authenticate_admin_user!
      unless current_user && current_user.admin?
        redirect_to(root_url, notice: "You need to be authenticated")
     end
  end

  def current_user
    @current_user ||= if session[:user_id]
      User.find_by_id(session[:user_id])
    end
  end
  helper_method :current_user
end
