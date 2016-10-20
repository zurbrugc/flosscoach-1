class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  def set_locale

    if params[:locale] == "en"
      I18n.default_locale = "en"
    elsif params[:locale] == "pt-BR"
      I18n.default_locale = "pt-BR"
    end

    I18n.locale = params[:locale] || I18n.default_locale
  end

  private

  def current_user
    @current_user ||= if session[:user_id]
      User.find_by_id(session[:user_id])
    end
  end
  helper_method :current_user
end
