class Public::GoalsController < ApplicationController
  before_action :set_user

  def new
  end



  private

  def set_user
    @current_user = current_user
  end

end
