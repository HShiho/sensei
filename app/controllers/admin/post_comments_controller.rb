class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @user = User.find(params[:id])
    @post_comments = PostComment.where(user_id: @user).order("created_at DESC").page(params[:page])
  end

  def destroy
    if PostComment.find(params[:id]).destroy
      redirect_to admin_post_path(params[:post_id])
    else
      redirect_to admin_post_path(params[:post_id]), notice: 'コメントの削除に失敗しました。'
    end
  end

end
