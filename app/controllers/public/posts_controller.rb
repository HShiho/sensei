class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @user = @current_user
    set_goal
    if params[:tag_ids] #タグ検索
      @posts = []
      @selects = params[:tag_ids].select{|key, value| value == "1"}
      if @selects.empty?
        @posts = Post.where(is_released: true).order("created_at DESC").page(params[:page])
      else
        @selects.each do |key, value|
          tag_posts = Tag.find_by(name: key).posts.where(is_released: true).order("created_at DESC").page(params[:page])
          return @posts = @posts.blank? ? tag_posts : @posts & tag_posts
        end
      end
    elsif params[:search] #キーワード検索
      @posts = Post.where("body LIKE ? OR tomorrow_objective LIKE ?",'%' + params[:search] + '%','%' + params[:search] + '%').order("created_at DESC")
      @posts = @posts.where(is_released: true).page(params[:page])
    else
      @posts = Post.where(is_released: true).order("created_at DESC").page(params[:page])
    end
  end

  def user_index
    @user = User.find(params[:id])
    is_deleted_redirect
    @post = Post.where(user_id: @user.id)
    set_goal
    if params[:tag_ids] # タグ検索
      @selects = params[:tag_ids].select{|key, value| value == "1"}
      @posts = []
      if @user == @current_user
        if @selects.empty?
          @posts = Post.where(user_id: @user.id).order("created_at DESC").page(params[:page])
        else
          @selects.each do |key, value|
            tag_posts = Tag.find_by(name: key).posts.where(user_id: @user.id).order("created_at DESC").page(params[:page])
            return @posts = @posts.blank? ? tag_posts : @posts & tag_posts
          end
        end
      else
        if @selects.empty?
          @posts_released = Post.where(user_id: @user.id, is_released: true).order("created_at DESC").page(params[:page])
        else
          @selects.each do |key, value|
            tag_posts = Tag.find_by(name: key).posts.where(user_id: @user.id, is_released: true).order("created_at DESC").page(params[:page])
            return @posts_released = @posts_released.blank? ? tag_posts : @posts_released & tag_posts
          end
        end
      end
    else
      @posts = Post.where(user_id: @user.id).order("created_at DESC").page(params[:page]) #current_user用(非公開込み)
      @posts_released = @posts.where(is_released: true).order("created_at DESC").page(params[:page]) #他userの投稿一覧(公開のみ)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post_id = @post.user_id
    @post.destroy
    redirect_to public_user_posts_path(@post_id)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    is_deleted_redirect
    set_goal
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.all.order("created_at DESC")
  end

  def create
    @new_post = Post.new(post_params)
    @new_post.user_id = current_user.id
    @new_post.start_time = Date.today
    if @new_post.save
      redirect_to public_user_posts_path(@new_post.user_id)
    else
      @new_post = Post.new
      @user = @current_user
      @posts = Post.where(user_id: @user.id)
      @post = @posts.group(:start_time)
      @goal = Goal.where(user_id: @user.id)
      @goal = @goal.where(is_completed: 0).last
      if @goal.present?
        @objectives = Objective.where(goal_id: @goal.id)
        @objective_month = @objectives.where(period_genre: 0).last
        @objective_week = @objectives.where(period_genre: 1).last
        @objectives_months = @objectives.where(period_genre: 0).order("created_at DESC")
        @objectives_weeks = @objectives.where(period_genre: 1).order("created_at DESC")
        @objective_day = @posts.where.not(tomorrow_objective: "").last
      end
      if params[:tag]
        Tag.create(name: params[:tag])
      end
      @hash = [{enum: 'excellence', icon: 'laugh-squint', checked: true}, {enum: 'good', icon: 'smile', checked: false}, {enum: 'almost', icon: 'rolling-eyes', checked: false}]

      flash.now[:alert] = "投稿できませんでした。入力内容を確認の上、もう一度お願いします。"
      render template: "public/homes/top"
  
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to public_post_path(@post)
  end


  private

  def set_goal
    @goal = Goal.where(user_id: @user.id)
    @goal = @goal.where(is_completed: 0).last
  end

  def is_deleted_redirect
    if @user.is_deleted == true
      redirect_to public_not_browse_path
    end
  end

  def post_params
    params.require(:post).permit(:user_id, :achivement, :body, :tomorrow_objective, :is_released, :start_time, :image, tag_ids: [])
  end


end
