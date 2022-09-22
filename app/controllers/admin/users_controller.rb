class Admin::UsersController < ApplicationController
  def index
    @users = User.all
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
      redirect_to public_user_path(@user)
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
