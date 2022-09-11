# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def after_sign_in_path_for(resource)
    public_root_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  # ゲストログイン
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to public_root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  # 会員論理削除、退会後は同じアカウントでサインインできないようにする
  def reject_customer
    @user = User.find_by(email: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == false)
        redirect_to new_user_session_path
      else
      end
    end
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
