class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @post_comments = PostComment.where(user_id: "#{params[:id]}").order("created_at DESC")
    @user = User.find(params[:id])
  end

  def destroy
    if PostComment.find(params[:id]).destroy
      redirect_to admin_post_path(params[:post_id])
    else
      redirect_to admin_post_path(params[:post_id]), notice: 'コメントの削除に失敗しました。'
    end
  end

end
