class Public::TopicsController < ApplicationController
  before_action :authenticate_user!

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = @current_user.id
    if @topic.save
      redirect_to public_topic_path(@topic), notice: '最初の投稿を行いましょう。'
    else
      redirect_to public_topics_path, notice: 'トピックの作成に失敗しました。'
    end
  end

  def index
    @user = @current_user
    set_goal
    if params[:tag_ids]
      @topics = []
      params[:tag_ids].each do |key, value|
        if value == "1"
          tag_topics = Tag.find_by(name: key).topics.order("created_at DESC")
          @topics = @topics.empty? ? tag_topics : @topics & tag_topics
        end
      end
    else
      @topics = Topic.all.order("created_at DESC")
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @topic_comment = TopicComment.new
    @topic_comments = @topic.topic_comments.all.order("created_at DESC")
  end



  private

  def set_goal
    @goal = Goal.where(user_id: @user.id)
    @goal = @goal.where(is_completed: 0).last
  end

  def topic_params
    params.require(:topic).permit(:user_id, :title, tag_ids: [])
  end

end
