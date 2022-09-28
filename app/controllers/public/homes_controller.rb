class Public::HomesController < ApplicationController
  before_action :set_user

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
    end
    # カレンダーに使用
    @posts = Post.where(user_id: @user.id)
    @posts = @posts.group(:start_time)
  end


private

  def set_user
    @current_user = current_user
  end

end
