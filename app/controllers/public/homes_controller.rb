class Public::HomesController < ApplicationController
  before_action :set_user

  def top
    @new_post = Post.new
    # simple_calendarに反映させるためにpost->event
      @events = Post.where(user_id: @current_user.id)
  end


private

  def set_user
    @current_user = current_user
  end

end
