class Public::PostsController < ApplicationController
  before_action :set_user

  def index
    @posts = Post.all
    @tag = Tag.all
  end

  def user_index
    @posts = Post.where(user_id: "#{params[:id]}")
    @post = Post.where(user_id: "#{params[:id]}").first
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
    @posts = Post.where(user_id: "#{params[:id]}")
    @posts_released = @posts.where(is_released: true)
  end

  def create
    @new_post = Post.new(post_params)
    @new_post.user_id = current_user.id
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
    params.require(:post).permit(:user_id, :achivement, :body, :tomorrow_objective, :is_released, :image, tag_ids: [])
  end


end