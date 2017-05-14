class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  layout :choose_layout
  add_flash_types :error, :alert, :success, :info
  include SessionsHelper

  def set_locale
    if params[:locale] == "en"
      I18n.default_locale = "en"
    elsif params[:locale] == "pt-BR"
      I18n.default_locale = "pt-BR"
    end
    I18n.locale = params[:locale] || I18n.default_locale
  end

  private
  def choose_layout
    if current_user
      "application"
    else
      "visitor"
    end
  end
  def authenticate_admin_user!
    unless current_user && current_user.admin?
      redirect_to(root_url, notice: "You need to be authenticated")
    end
  end

  def authorize
    unless logged_in?
      redirect_to sign_in_path
    end
  end

end
