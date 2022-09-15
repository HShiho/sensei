class Public::UsersController < ApplicationController
  def index
  end

  def show
  end



  private

  def user_params
    params.require(:post).permit(:nickname, :email, :is_deleted, :image )
  end

end
