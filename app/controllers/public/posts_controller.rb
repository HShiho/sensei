class Public::PostsController < ApplicationController
  before_action :set_user

  def index
  end

  def user_index
  end

  def show
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to public_user_posts_path(@post.user_id)
    else
      render public_root_path
    end
  end


  private

  def set_user
    @current_user = current_user
  end

  def post_params
    params.require(:post).permit(:user_id, :post_tag_id, :achivement, :body, :tomorrow_objective, :is_released)
  end

end
