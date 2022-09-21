class Public::PostsController < ApplicationController
  before_action :set_user

  def index
    @posts = Post.all.order("created_at DESC")
    @posts_released = @posts.where(is_released: true)
    if params[:tag_ids]
      @posts_released = []
      params[:tag_ids].each do |key, value|
        if value == "1"
          tag_posts = Tag.find_by(name: key).posts
          @posts_released = @posts.empty? ? tag_posts : @posts & tag_posts
        end
      end
    end
  end

  def user_index
    @post_all = Post.all.order("created_at DESC")
    @posts = @post_all.where(user_id: "#{params[:id]}")
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
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.all.order("created_at DESC")
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
