class Admin::TopicCommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @user = User.find(params[:id])
    @topic_comments = TopicComment.where(user_id: @user).order("created_at DESC").page(params[:page])
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    comment = TopicComment.find(params[:id])
    if comment.destroy
      redirect_to admin_topic_path(@topic)
    else
      redirect_to admin_topic_path(@topic), notice: 'コメントの削除に失敗しました。'
    end
  end

end
