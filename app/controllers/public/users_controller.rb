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

  def favorites
    @user = User.find(params[:id])
    if params[:type] == "nice"
      favorites = Favorite.where(user_id: @user.id, type: "nice").pluck(:post_id)
    elsif params[:type] == "like"
      favorites = Favorite.where(user_id: @user.id, type: "like").pluck(:post_id)
    elsif params[:type] == "fight"
      favorites = Favorite.where(user_id: @user.id, type: "fight").pluck(:post_id)
    else
      favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    end
     @favorite_posts = Post.find(favorites)
  end



  private

  def set_user
    @current_user = current_user
  end

  def user_params
    params.require(:user).permit(:nickname, :email, :is_deleted, :image )
  end

end
