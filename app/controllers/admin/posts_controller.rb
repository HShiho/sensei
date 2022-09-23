class Admin::PostsController < ApplicationController
  def index
    @post = Post.find(params[:id])
    if params[:tag_ids]
      @posts = []
      params[:tag_ids].each do |key, value|
        if value == "1"
          tag_posts = Tag.find_by(name: key).posts
          @posts = @posts.empty? ? tag_posts : @posts & tag_posts
          @posts = @posts.where(user_id: "#{params[:id]}")
        end
      end
    else
      @posts = Post.where(user_id: "#{params[:id]}")
    end
    @posts = @posts.order("created_at DESC")
    @posts_released = @posts.where(is_released: true)
  end

  def show
    @post = Post.find(params[:id])
    @post_comments = @post.post_comments.all.order("created_at DESC")
  end



  private

  def post_params
    params.require(:post).permit(:user_id, :achivement, :body, :tomorrow_objective, :is_released, :image, tag_ids: [])
  end


end
