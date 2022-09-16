class Public::FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:id])
    favorite = current_user.favorites.new
    favorite.post_id = @post.id
    if params[:post][:button] == "1"
      favorite.type = [:nice]
      favorite.save
      render public_user_posts_path(@post.user.id)
      # redirect_to public_post_path(@post)
    end
  end

  def delete
  end

end
