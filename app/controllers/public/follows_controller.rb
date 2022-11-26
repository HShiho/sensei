class Public::FollowsController < ApplicationController
   before_action :authenticate_user!

  def show
    @user = User.find(params[:user_id])
    @follows = Follow.where(user_id: params[:user_id])

  end

  def create
    follow = Follow.new(follower_id: params[:user_id], user_id: current_user.id)
    follow.save
    redirect_to public_user_follows_path(user_id: current_user.id)
  end

  def destroy
    follow = Follow.find_by(follower_id: params[:user_id], user_id: current_user.id)
    follow.destroy
    redirect_to public_user_follows_path(user_id: current_user.id)
  end


  private

  def follow_params
    params.require(:follow).permit(:user_id, :follower_id)
  end


end
