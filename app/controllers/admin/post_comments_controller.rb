class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @post_comment = PostComment.find(params[:id])
    @post_comments = PostComment.where(user_id: "#{params[:id]}").order("created_at DESC")
  end

  def destroy
    if PostComment.find(params[:id]).destroy
      redirect_to admin_post_path(params[:post_id])
    else
      render template: "admin/posts/show", notice: 'コメントの削除に失敗しました。'
    end
  end

end
