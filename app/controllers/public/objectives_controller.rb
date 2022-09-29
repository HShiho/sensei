class Public::ObjectivesController < ApplicationController
  before_action :set_user

  def new
    @objective = Objective.new
    @goal = Goal.where(user_id: @current_user.id)
    @goal = @goal.where(is_completed: 0).last
  end

  def create
    @objective = Objective.new(objective_params)
    if @objective.save
      redirect_to public_root_path
    else
      render new_public_objective_path
    end
  end

  def edit
  end


  private

  def set_user
    @current_user = current_user
  end

  def objective_params
    params.require(:objective).permit(:goal_id, :period_genre, :title, :did_it, :could_not )
  end

end
