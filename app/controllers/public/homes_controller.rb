class Public::HomesController < ApplicationController
  before_action :set_user

  def top
    @new_post = Post.new
  end


private

  def set_user
    @current_user = current_user
  end

end
