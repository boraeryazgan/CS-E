class ProfilesController < ApplicationController
    before_action :require_login
  
    def show
      @profile = current_user.profile || current_user.build_profile
    end
  
    def edit
      @profile = current_user.profile || current_user.build_profile
    end
  
    def update
        @profile = current_user.profile || current_user.build_profile
        if @profile.update(profile_params)
          redirect_to profile_path, notice: "Profil başarıyla güncellendi!"
        else
          flash.now[:alert] = "Profil güncellenemedi. Hataları kontrol edin."
          render :edit, status: :unprocessable_entity
        end
      end
    
  
    private
  
    def require_login
      redirect_to login_path, alert: "Önce giriş yapmalısınız!" unless current_user
    end
  
    def profile_params
      params.require(:profile).permit(:bio, :location, :age, :gender, :interests)
    end
  
    def current_user
      @current_user ||= User.find(session[:user_id])
    end
  end