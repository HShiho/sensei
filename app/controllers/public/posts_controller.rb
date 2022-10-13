class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @user = @current_user
    set_goal
    if params[:tag_ids] #タグ検索
      @posts = []
      params[:tag_ids].each do |key, value|
        if value == "1"
          tag_posts = Tag.find_by(name: key).posts.where(is_released: true).order("created_at DESC").page(params[:page])
          @posts = @posts.empty? ? tag_posts : @posts & tag_posts
        end
      end
    elsif params[:search] #キーワード検索
      @posts = Post.where("body LIKE ? OR tomorrow_objective LIKE ?",'%' + params[:search] + '%','%' + params[:search] + '%').order("created_at DESC")
      @posts = @posts.where(is_released: true).page(params[:page])
    else
      @posts = Post.where(is_released: true).order("created_at DESC").page(params[:page])
    end
  end

  def user_index
    @user = User.find(params[:id])
    is_deleted_redirect
    @post = Post.where(user_id: @user.id)
    set_goal
    if params[:tag_ids] # タグ検索
      @posts = []
      @posts_released = []
      params[:tag_ids].each do |key, value|
        if value == "1"
          tag_posts = Tag.find_by(name: key).posts.where(user_id: @user.id).order("created_at DESC")
          tag_posts_released = Tag.find_by(name: key).posts.where(user_id: @user.id, is_released: true).order("created_at DESC")
          @posts = @posts.empty? ? tag_posts : @posts & tag_posts
          @posts_released = @posts_released.empty? ? tag_posts_released : @posts_released & tag_posts_released
        end
      end
    else
      @posts = Post.where(user_id: @user.id).order("created_at DESC") #current_user用(非公開込み)
      @posts_released = @posts.where(is_released: true) #他userの投稿一覧(公開のみ)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post_id = @post.user_id
    @post.destroy
    redirect_to public_user_posts_path(@post_id)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    is_deleted_redirect
    set_goal
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.all.order("created_at DESC")
  end

  def create
    @new_post = Post.new(post_params)
    @new_post.user_id = current_user.id
    @new_post.start_time = Date.today
    if @new_post.save
      redirect_to public_user_posts_path(@new_post.user_id)
    else
      redirect_to public_root_path, notice: '投稿できませんでした。入力内容を確認の上、もう一度お願いします。'
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to public_post_path(@post)
  end


  private

  def set_goal
    @goal = Goal.where(user_id: @user.id)
    @goal = @goal.where(is_completed: 0).last
  end

  def is_deleted_redirect
    if @user.is_deleted == true
      redirect_to public_not_browse_path
    end
  end

  def post_params
    params.require(:post).permit(:user_id, :achivement, :body, :tomorrow_objective, :is_released, :start_time, :image, tag_ids: [])
  end


end
