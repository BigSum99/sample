module Users
  class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user

    def show
    end

    def edit
    end

    def update
      if @user.update(user_params)
        redirect_to users_profile_path, notice: 'プロフィールが更新されました。'
      else
        render :edit
      end
    end

    private

    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:username, :introduction, :profile_image)
    end
  end
end
