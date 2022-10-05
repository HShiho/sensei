class Public::HomesController < ApplicationController

  def top
    @new_post = Post.new
    @user = @current_user

    # 現在の目標欄に使用
    @goal = Goal.where(user_id: @user.id)
    @goal = @goal.where(is_completed: 0).last
    if @goal.present?
      @objectives = Objective.where(goal_id: @goal.id)
      @objective_month = @objectives.where(period_genre: 0).last
      @objective_week = @objectives.where(period_genre: 1).last
      # 月目標を降順で取得
      @objectives_month = @objectives.where(period_genre: 0)
      @objectives_month = @objectives_month.order("created_at DESC")
      # 週目標を降順で取得
      @objectives_week = @objectives.where(period_genre: 1)
      @objectives_week = @objectives_week.order("created_at DESC")
      # 日の目標を取得
      @objective_day = @Post.where(user_id: @current_user.id)
    end

    # カレンダーに使用
    @posts = Post.where(user_id: @user.id)
    @posts = @posts.group(:start_time)
  end



end
