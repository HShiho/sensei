class Public::PostsController < ApplicationController
  before_action :set_user

  def index
    @user = @current_user
    @goal = Goal.where(user_id: @user.id)
    @goal = @goal.where(is_completed: 0).last
    if params[:tag_ids]
      @posts = []
      params[:tag_ids].each do |key, value|
        if value == "1"
          tag_posts = Tag.find_by(name: key).posts
          @posts = @posts.empty? ? tag_posts : @posts & tag_posts
        end
      end
    elsif params[:search]
      @posts = Post.where("body LIKE ? OR tomorrow_objective LIKE ?",'%' + params[:search] + '%','%' + params[:search] + '%')
    else
      @posts = Post.all
    end
      @posts = @posts.order("created_at DESC")
      @posts_released = @posts.where(is_released: true)
  end

  def user_index
    @post = Post.where(user_id: "#{params[:id]}").first
    @user = @post.user
    @goal = Goal.where(user_id: @user.id)
    @goal = @goal.where(is_completed: 0).last
    if params[:tag_ids]
      @posts = []
      params[:tag_ids].each do |key, value|
        if value == "1"
          tag_posts = Tag.find_by(name: key).posts
          @posts = @posts.empty? ? tag_posts : @posts & tag_posts
          @posts = @posts.where(user_id: @user.id)
        end
      end
    else
      @posts = Post.where(user_id: @user.id)
    end
    @posts = @posts.order("created_at DESC")
    @posts_released = @posts.where(is_released: true)
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
    @goal = Goal.where(user_id: @user.id)
    @goal = @goal.where(is_completed: 0).last
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
      render public_root_path
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to public_post_path(@post)
  end


  private

  def set_user
    @current_user = current_user
  end

  def post_params
    params.require(:post).permit(:user_id, :achivement, :body, :tomorrow_objective, :is_released, :start_time, :image, tag_ids: [])
  end


end
