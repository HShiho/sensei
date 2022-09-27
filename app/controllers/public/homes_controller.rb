class Public::HomesController < ApplicationController
  before_action :set_user

  def top
    @new_post = Post.new
    @user = @current_user
    @goal = Goal.where(user_id: @current_user.id).last
    @present_goal = @goal.presence || '目標が設定されていません'
    if @goal.present?
      @objectives = Objective.where(goal_id: @goal.id)
      @objective_month = @objectives.where(period_genre: 0).last.presence || '目標が設定されていません'
      @objective_week = @objectives.where(period_genre: 1).last.presence || '目標が設定されていません'
    else
      @objective_month = '最終目標を設定しましょう'
      @objective_week = '最終目標を設定しましょう'
    end
    # カレンダーに使用
    @posts = Post.where(user_id: @current_user.id)
    @posts = @posts.group(:start_time)
  end


private

  def set_user
    @current_user = current_user
  end

end
