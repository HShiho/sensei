class Public::ObjectivesController < ApplicationController
  before_action :authenticate_user!

  def new
    @objective = Objective.new
    @goal = Goal.where(user_id: @current_user.id)
    @goal = @goal.where(is_completed: 0).last
  end

  def create
    @objective = Objective.new(objective_params)
    if @objective.save
      redirect_to public_root_path, notice: '新しい中期目標が設定されました。'
    else
      @goal = Goal.where(user_id: @current_user.id)
      @goal = @goal.where(is_completed: 0).last
      render :new
    end
  end

  def edit
    @objective = Objective.find(params[:id])
  end

  def update
    @objective = Objective.find(params[:id])
    if @objective.update(objective_params)
      redirect_to public_root_path
    else
      render :edit
    end
  end


  private

  def objective_params
    params.require(:objective).permit(:goal_id, :period_genre, :title, :did_it, :could_not )
  end

end
