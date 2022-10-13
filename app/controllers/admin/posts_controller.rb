class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @user = User.find(params[:id])
    if params[:tag_ids] #タグ検索
      @posts = []
      params[:tag_ids].each do |key, value|
        if value == "1"
          tag_posts = Tag.find_by(name: key).posts.where(user_id: @user).order("created_at DESC").page(params[:page])
          @posts = @posts.empty? ? tag_posts : @posts & tag_posts
        end
      end
    elsif params[:search] #キーワード検索
      @posts = Post.where("body LIKE ? OR tomorrow_objective LIKE ?",'%' + params[:search] + '%','%' + params[:search] + '%').order("created_at DESC")
      @posts = @posts.where(user_id: @user).page(params[:page])
    else
      @posts = Post.where(user_id: @user).order("created_at DESC").page(params[:page])
    end
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
