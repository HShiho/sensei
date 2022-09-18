class Public::PostCommentsController < ApplicationController
  before_action :set_user

  def create
    @post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = @post.id
    comment.save
    redirect_to public_post_path(@post)
  end

  def destroy
    post_comment = PostComment.find(params[:id])
    post_id = post_comment.post_id
    post_comment.destroy
    redirect_to public_post_path(post_id)
  end




  private

  def set_user
    @current_user = current_user
  end

  def post_comment_params
    params.require(:post_comment).permit(:body)
  end

end
