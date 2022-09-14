class Public::PostsController < ApplicationController
  before_action :set_user

  def index
    @posts = Post.all
  end

  def user_index
  end

  def show
  end

  def create
    @new_post = Post.new(post_params)
    @new_post.user_id = current_user.id
    if @new_post.save
      redirect_to public_root_path
      # redirect_to public_user_posts_path(@new_post.user_id)
    else
      render public_root_path
    end
  end


  private

  def set_user
    @current_user = current_user
  end

  def post_params
    params.require(:post).permit(:user_id, :post_tag_id, :achivement, :body, :tomorrow_objective, :is_released, :image)
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize_to_limit: [width, height]).processed
  end

end
