class Public::TopicsController < ApplicationController
  before_action :set_user

  def new
    @topic = Topic.new
  end

  def index
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

  def set_user
    @current_user = current_user
  end
  
  def set_goal
    @goal = Goal.where(user_id: @user.id)
    @goal = @goal.where(is_completed: 0).last
  end

  def topic_params
    params.require(:topic).permit(:user_id, :title, tag_ids: [] )
  end

end
