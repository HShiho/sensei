class Public::GoalsController < ApplicationController
  before_action :set_user

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = @current_user.id
    if @goal.save
      redirect_to public_induction_path
    else
      render 
    end
  end

  def update
    @goal = Goal.find(params[:id])
    @goal.update(goal_params)
    redirect_to public_root_path
  end

  def induction
  end



  private

  def set_user
    @current_user = current_user
  end

  def goal_params
    params.require(:goal).permit(:user_id, :title, :is_completed)
  end

end
