class Public::HomesController < ApplicationController
  before_action :set_user

  def top
    @new_post = Post.new
      @posts = Post.where(user_id: @current_user.id)
      @posts = @posts.group(:start_time)
  end


private

  def set_user
    @current_user = current_user
  end

end
