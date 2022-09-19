class Public::UsersController < ApplicationController
  before_action :set_user

  def index
    @users = User.where.not(nickname: 'ゲストユーザー')
  end

  def show
    @user = User.find(params[:id])
    @goal = Goal.where(user_id: "#{params[:id]}").last
  end

  def edit
    @user = User.find(params[:id])
    @goal = Goal.where(user_id: "#{params[:id]}").last
    if @user.id != @current_user.id
      redirect_to public_users_path, notice: 'このページにはアクセスできません'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to public_user_path(@user)
    else
      @user = User.find(@user)
      render :edit
    end
  end



  private

  def set_user
    @current_user = current_user
  end

  def user_params
    params.require(:user).permit(:nickname, :email, :is_deleted, :image )
  end

end
