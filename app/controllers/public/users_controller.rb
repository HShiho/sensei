class Public::UsersController < ApplicationController
  before_action :set_user

  def index
    @users = User.where.not(nickname: 'ゲストユーザー')
  end

  def show
    @user = User.find(params[:id])
    @goal = Goal.where(user_id: "#{params[:id]}").last
  end



  private

  def set_user
    @current_user = current_user
  end

  def user_params
    params.require(:post).permit(:nickname, :email, :is_deleted, :image )
  end

end
