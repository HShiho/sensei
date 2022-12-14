class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:search]
      @users = User.where("nickname LIKE ?",'%' + params[:search] + '%').page(params[:page])
    else
      @users = User.all.page(params[:page])
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user)
    else
      @user = User.find(@user)
      render :edit
    end
  end


   private

  def user_params
    params.require(:user).permit(:nickname, :email, :is_deleted, :image )
  end

end
