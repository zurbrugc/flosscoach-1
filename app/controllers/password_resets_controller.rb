class PasswordResetsController < ApplicationController
  before_action :block_access

def create
  user = User.find_by_email(params[:email])
  if user && user.email_confirmed?
    user.send_password_reset
    redirect_to root_url, :notice => "Email sent with password reset instructions."
  else
    flash.now[:alert] = "The email was not found registered in our database."
    render :new
  end
end

def edit
  @user = User.find_by_password_reset_token!(params[:id])
end

def update
  @user = User.find_by_password_reset_token!(params[:id])
  if @user.password_reset_sent_at < 2.hours.ago
    redirect_to new_password_reset_path, :alert => "Password reset has expired."
  elsif @user.update_attributes(user_params)
    redirect_to root_url, :notice => "Password has been reset!"
  else
    render :edit
  end
 end


  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
