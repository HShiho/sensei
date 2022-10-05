class Public::TopicCommentsController < ApplicationController

  def create
    @topic = Topic.find(params[:topic_id])
    comment = TopicComment.new(topic_comment_params)
    comment.user_id = @topic.user_id
    comment.topic_id = @topic.id
    if comment.save
      redirect_to public_topic_path(@topic)
    else
      render template: "topics/show", notice: 'コメントの作成に失敗しました。'
    end
  end


  def destroy
    @topic = Topic.find(params[:topic_id])
    comment = TopicComment.find(params[:id])
    if comment.destroy
      redirect_to public_topic_path(@topic)
    else
      render template: "topics/show", notice: 'コメントの削除に失敗しました。'
    end
  end



  private

  def topic_comment_params
    params.require(:topic_comment).permit(:body)
  end

end
