class Public::HomesController < ApplicationController
  before_action :authenticate_user!, except: [:about]

  def top
    @new_post = Post.new
    @user = @current_user
    @hash = achivement_hash

    # カレンダーに使用
    @posts = Post.where(user_id: @user.id)
    @post = @posts.group(:start_time)

    # 現在の目標欄に使用
    @goal = Goal.where(user_id: @user.id)
    @goal = @goal.where(is_completed: 0).last
    if @goal.present?
      @objectives = Objective.where(goal_id: @goal.id)
      @objective_month = @objectives.where(period_genre: 0).last
      @objectives_months = @objectives.where(period_genre: 0).order("created_at DESC")
      @objective_week = @objectives.where(period_genre: 1).last
      @objectives_weeks = @objectives.where(period_genre: 1).order("created_at DESC")
      @objective_day = @posts.where.not(tomorrow_objective: "").last
    end

    if params[:tag]
      Tag.create(name: params[:tag])
    end

    @my_post_favorite_ranks = current_user.posts.sort { |a, b| b.favorites.count <=> a.favorites.count }.first(3)
  end

  def about
  end

  def rank
    @my_post_favorite_ranks = current_user.posts.sort { |a, b| b.favorites.count <=> a.favorites.count }.first(5)
    @post_favorite_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').pluck(:post_id)).first(5)

    @my_post_comment_ranks = current_user.posts.sort { |a, b| b.post_comments.count <=> a.post_comments.count }.first(5)
    @post_comment_ranks = Post.find(PostComment.group(:post_id).order('count(post_id) desc').pluck(:post_id)).first(5)

    @follower_ranks = User.find(Relationship.group(:followed_id).order('count(followed_id) desc').pluck(:followed_id)).first(5)
  end



  private

  def post_params
    params.require(:tag).permit(:name)
  end


end
