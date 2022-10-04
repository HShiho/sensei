class Public::TopicsController < ApplicationController

  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = @current_user.id
    if @topic.save
      redirect_to public_topics_path
    else
      render public_topics_path, notice: 'トピックの作成に失敗しました。'
    end
  end

  def index
    @topic = Topic.new
    @topic_comment = TopicComment.new
    @user = @current_user
    set_goal
    if params[:tag_ids]
      @topics = []
      params[:tag_ids].each do |key, value|
        if value == "1"
          tag_topics = Tag.find_by(name: key).topics
          @topics = @topics.empty? ? tag_topics : @topics & tag_topics
        end
      end
    else
      @topics = Topic.all
    end
    @topics = @topics.order("created_at DESC")
  end

  def show
    @topic = Topic.find(params[:id])
  end



  private

  def set_goal
    @goal = Goal.where(user_id: @user.id)
    @goal = @goal.where(is_completed: 0).last
  end

  def topic_params
    params.require(:topic).permit(:user_id, :title) #, tag_ids: [] )
  end

end
