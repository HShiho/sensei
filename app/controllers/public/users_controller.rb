class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    # @users = User.where.not(nickname: 'ゲストユーザー')
    @users = User.where.not(is_deleted: true).page(params[:page])
    @user = @current_user
    @goal = Goal.where(user_id: @user.id)
    @goal = @goal.where(is_completed: 0).last
  end

  def show
    @user = User.find(params[:id])
    @goals = Goal.where(user_id: "#{params[:id]}")
    @goal = @goals.where(is_completed: 0).last
    if @user.is_deleted == true
      redirect_to public_not_browse_path
    end
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
    if @user.email == 'guest@sample.com'
      if @user.update(gust_user_params)
        redirect_to public_user_path(@user)
      else
        @user = User.find(params[:id])
        render :edit
      end
    else
      if @user.update(user_params)
        redirect_to public_user_path(@user)
      else
        @user = User.find(params[:id])
        render :edit
      end
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
    @other_user = User.where.not(email: 'guest@sample.com', id: @user.id).find_by(is_deleted: false)
  end

  def withdrawal
  end

  def breakaway
    id = params[:user_id]
    @user = User.find(id)
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理が完了しました。またいつか、その時を楽しみにお待ちしています。"
    redirect_to new_user_session_path
  end



  private

  def user_params
    params.require(:user).permit(:nickname, :email, :is_deleted, :icon_image )
  end

  def gust_user_params
    params.require(:user).permit( :nickname, :icon_image )
  end

end
