class UsersController < ApplicationController
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to profile_path, notice: "Başarıyla kayıt oldunuz!"
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def login_form
      # Giriş formu için
    end
  
    def login
        @user = User.find_by(email: params[:email].downcase)
        if @user&.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect_to profile_path, notice: "Giriş başarılı!"
        else
          flash.now[:alert] = "E-posta veya şifre hatalı. Lütfen tekrar deneyin."
          render :login_form, status: :unprocessable_entity
        end
    end
  
    def logout
        session.delete(:user_id)
        redirect_to login_path, notice: "Başarıyla çıkış yaptınız!"
      end
  
    private
  
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
  end