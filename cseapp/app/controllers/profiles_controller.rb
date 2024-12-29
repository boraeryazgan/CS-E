class ProfilesController < ApplicationController
    before_action :authenticate_user!
  
    def show
      @user = current_user
    end
  
    def edit
      @user = current_user
    end
  
    def update
      @user = current_user
      if @user.update(profile_params)
        redirect_to profile_path, notice: 'Profil başarıyla güncellendi.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    private
    def profile_params
      params.require(:user).permit(:first_name, :last_name, :email, :age, :gender, :interests, :about, :password, :password_confirmation,:twitter,:linkedin)
    end
  end