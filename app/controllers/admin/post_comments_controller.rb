class Admin::PostCommentsController < ApplicationController

  def index
    @post_comment = PostComment.find(params[:id])
    @post_comments = PostComment.where(user_id: "#{params[:id]}")
    @post_comments = @post_comments.order("created_at DESC")
  end


  private

  def post_params
    params.require(:post_comments).permit(:user_id, :post_id, :body)
  end
end
