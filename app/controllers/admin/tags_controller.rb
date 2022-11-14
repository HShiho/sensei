class Admin::TagsController < ApplicationController

  def index
    @tags = Tag.all.page(params[:page])
  end

  def update
    @tag = Tag.find(params[:id])
    @tag.update(tag_params)
    redirect_to admin_tags_path
  end


   private

  def tag_params
    params.permit(:name)
  end

end
