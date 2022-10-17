class Admin::TopicCommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @topic_comments = TopicComment.where(user_id: "#{params[:id]}").order("created_at DESC")
    @user = User.find(params[:id])
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    comment = TopicComment.find(params[:id])
    if comment.destroy
      redirect_to admin_topic_path(@topic)
    else
      render template: "admin/topics/show", notice: 'コメントの削除に失敗しました。'
    end
  end

end
