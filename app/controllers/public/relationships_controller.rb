class Public::RelationshipsController < ApplicationController
   before_action :authenticate_user!

  def show
    @user = current_user
    @following_users = @user.followings
    @follower_users = @user.followers
  end

  def create
    follow = Relationship.new(followed_id: params[:user_id], follower_id: current_user.id)
    follow.save
    redirect_to public_user_relationships_path(follower_id: current_user.id)
  end

  def destroy
    follow = Relationship.find_by(followed_id: params[:user_id], follower_id: current_user.id)
    follow.destroy
    redirect_to public_user_relationships_path(foolower_id: current_user.id)
  end





end
