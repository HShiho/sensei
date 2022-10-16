class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = @post.id
    if comment.save
      redirect_to public_post_path(@post)
    else
      redirect_to public_post_path(@post), notice: 'コメントの作成に失敗しました。'
    end
  end

  def destroy
    if PostComment.find(params[:id]).destroy
      redirect_to public_post_path(params[:post_id])
    else
      render template: "public/posts/show", notice: 'コメントの削除に失敗しました。'
    end
  end




  private

  def post_comment_params
    params.require(:post_comment).permit(:body)
  end

  def set_goal
    @goal = Goal.where(user_id: @user.id)
    @goal = @goal.where(is_completed: 0).last
  end

end
