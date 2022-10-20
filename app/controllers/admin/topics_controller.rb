class Admin::TopicsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @user = User.find(params[:id])
    if params[:tag_ids] #タグ検索
      @topics = []
      @selects = params[:tag_ids].select{|key, value| value == "1"}
      if @selects.empty?
        @topics = Topic.where(user_id: @user).order("created_at DESC").page(params[:page])
      else
        @selects.each do |key, value|
          tag_posts = Tag.find_by(name: key).topics.where(user_id: @user).order("created_at DESC").page(params[:page])
          return @topics = @topics.empty? ? tag_posts : @topics & tag_posts
        end
      end
    else
      @topics = Topic.where(user_id: @user).order("created_at DESC").page(params[:page])
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @topic_comments = @topic.topic_comments.all.order("created_at DESC")
  end
end
