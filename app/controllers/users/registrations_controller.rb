class Users::RegistrationsController < Devise::RegistrationsController
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @user = current_user
  end

  protected

  # サインアップ後のリダイレクト先をアカウント詳細ページに設定
  def after_sign_up_path_for(resource)
    user_account_path
  end

  # アカウント編集後のリダイレクト先をアカウント詳細ページに設定
  def after_update_path_for(resource)
    user_account_path
  end

  private

  def set_user
    @user = current_user
  end
end
