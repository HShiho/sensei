class Public::FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: @post.id)
    if  params[:button].to_i == 1
      favorite.type = "nice"
    elsif params[:button].to_i == 2
      favorite.type = "like"
    else
      favorite.type = "fight"
    end
    favorite.save
      redirect_to public_post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
      redirect_to public_post_path(@post)
  end



end
