class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where.not(nickname: 'ゲストユーザー')
    @users = @users.where.not(is_deleted: true)
    @user = @current_user
    @goal = Goal.where(user_id: @user.id)
    @goal = @goal.where(is_completed: 0).last
  end

  def show
    @user = User.find(params[:id])
    @goals = Goal.where(user_id: "#{params[:id]}")
    @goal = @goals.where(is_completed: 0).last
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
    @goal = Goal.where(user_id: @user.id)
    @goal = @goal.where(is_completed: 0).last
    if params[:type] == "nice"
      @type = Favorite.types_i18n[:nice]
      favorites = Favorite.where(user_id: @user.id, type: "nice")
    elsif params[:type] == "like"
      @type = Favorite.types_i18n[:like]
      favorites = Favorite.where(user_id: @user.id, type: "like")
    elsif params[:type] == "fight"
      @type = Favorite.types_i18n[:fight]
      favorites = Favorite.where(user_id: @user.id, type: "fight")
    else
      favorites = Favorite.where(user_id: @user.id)
    end
    favorites = favorites.order("created_at DESC")
    favorites = favorites.pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  def withdrawal
  end

  def breakaway
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理が完了しました。またいつか、その時を楽しみにお待ちしています。"
    redirect_to new_user_session_path
  end



  private

  def user_params
    params.require(:user).permit(:nickname, :email, :is_deleted, :image )
  end

end
