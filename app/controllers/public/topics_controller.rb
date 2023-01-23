class Public::TopicsController < ApplicationController
  before_action :authenticate_user!

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = @current_user.id
    if @topic.save
      redirect_to public_topic_path(@topic), notice: '最初の投稿をしましょう。'
    else
      render :new
    end
  end

  def index
    @user = @current_user
    set_goal
    if params[:tag_ids]
      @topics = []
      @selects = params[:tag_ids].select{|key, value| value == "1"}
      if @selects.empty?
        @topics = Topic.all.order("created_at DESC").page(params[:page])
      else
        @selects.each do |key, value|
          tag_topics = Tag.find_by(name: key).topics.order("created_at DESC").page(params[:page])
          return @topics = @topics.blank? ? tag_topics : @topics & tag_topics
        end
      end
    else
      @topics = Topic.all.order("created_at DESC").page(params[:page])
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @topic_comment = TopicComment.new
    @topic_comments = @topic.topic_comments.order("created_at DESC")
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
