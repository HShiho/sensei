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
      @objective_week = @objectives.where(period_genre: 1).last
      # 月目標を降順で取得
      @objectives_months = @objectives.where(period_genre: 0).order("created_at DESC")
      # 週目標を降順で取得
      @objectives_weeks = @objectives.where(period_genre: 1).order("created_at DESC")
      # 日の目標を取得
      @objective_day = @posts.where.not(tomorrow_objective: "").last
    end

    # タグ新規作成
    if params[:tag]
      Tag.create(name: params[:tag])
    end
    
    # ランキング
    @my_post_favorite_ranks = current_user.posts.sort { |a, b| b.favorites.count <=> a.favorites.count }
    
  end

  def about
  end



  private

  def post_params
    params.require(:tag).permit(:name)
  end


end
