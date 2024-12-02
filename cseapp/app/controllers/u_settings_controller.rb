class USettingsController < ApplicationController
  before_action :require_login

  def index
  end

  def update_password
    if current_user.update(password_params)
      redirect_to settings_path, notice: "Password updated successfully!"
    else
      flash.now[:alert] = "Password update failed. Please check your input."
      render :index, status: :unprocessable_entity
    end
  end

  def deactivate_account
    current_user.update(active: false)
    reset_session
    redirect_to root_path, notice: "Your account has been deactivated."
  end

  private

  def require_login
    redirect_to login_path, alert: "You must be logged in to access settings!" unless current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end