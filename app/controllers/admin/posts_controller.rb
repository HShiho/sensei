class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @user = User.find(params[:id])
    if params[:tag_ids] #タグ検索
      @posts = []
      @selects = params[:tag_ids].select{|key, value| value == "1"}
      params[:tag_ids].each do |key, value|
        tag_posts = Tag.find_by(name: key).posts.where(user_id: @user).order("created_at DESC").page(params[:page])
        return @posts = @posts.blank? ? tag_posts : @posts & tag_posts
      end
    else
      @posts = Post.where(user_id: @user).order("created_at DESC").page(params[:page])
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comments = @post.post_comments.all.order("created_at DESC")
  end

  def destroy
    @post = Post.find(params[:id])
    @post_id = @post.user_id
    @post.destroy
    redirect_to admin_posts_index_path(@post_id)
  end



  private

  def post_params
    params.require(:post).permit(:user_id, :achivement, :body, :tomorrow_objective, :is_released, :image, tag_ids: [])
  end


end
