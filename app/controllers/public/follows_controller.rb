class Public::FollowsController < ApplicationController
   before_action :authenticate_user!

  def show
    @user = User.find(params[:user_id])

    @follows = Follow.where(user_id: @user.id)
    @followers = Follow.where(follower_id: @user.id)
  end

  def create
    @user = User.find(params[:user_id])
    follow = current_user.follows.new(follower_id: params[:follower_id])
    follow.save
    redirect_to public_user_follows_path(user_id: current_user.id)
  end

  def destroy
    @user = User.find(params[:user_id])
    follow = current_user.follows.find_by(follower_id: params[:follower_id])
    follow.destroy
    redirect_to public_user_follows_path(user_id: current_user.id)
  end


end
