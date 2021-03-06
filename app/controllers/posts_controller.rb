class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy, :like,
                                   :unlike]
  before_action :authenticate_user!
  before_action :redirect_if_not_owner, only: [:edit, :update, :destroy]

  # To browse all posts
  def browse
    @comment = Comment.new
    @posts = Post.all.order('created_at DESC').page(params[:page]).per(3)
    respond_to do |format|
      format.html
      format.js
    end
  end

  # To browse posts created by users that current user follows
  def index
    @comment = Comment.new
    # @user_posts = current_user.posts.order('created_at DESC')
    # @following_posts = Post.of_followed_users(current_user.following)
    # @posts = (@user_posts + @following_posts)

    @ids = [current_user.id] + current_user.following.pluck(:id)
    @posts = Post.where(user_id: @ids).order('created_at DESC').page(params[:page]).per(3)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Post successfully created.'
      redirect_to profile_path(current_user.name)
    else
      flash.now[:warning] = 'Could not create post.'
      render 'new'
    end
  end

  def show
    @comment = Comment.new
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:success] = 'Post successfully updated.'
      redirect_to @post
    else
      flash.now[:warning] = 'Could not update post.'
      render 'edit'
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = 'Post deleted.'
      redirect_to root_path
    else
      flash.now[:warning] = 'Could not delete post.'
      render edit
    end
  end

  def like
    @post.liked_by current_user
    create_notification(@post)
    respond_to_vote
  end

  def unlike
    @post.unliked_by current_user
    respond_to_vote
  end

  private

  def post_params
    params.require(:post).permit(:caption, :image)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def redirect_if_not_owner
    return unless current_user.id != @post.user_id
    flash[:danger] = "That post dosen't belong to you!"
    redirect_to root_path
  end

  def create_notification(post)
    return if current_user == post.user
    Notification.create!(post: post,
                         notified_by: current_user,
                         user: post.user,
                         notice_type: 'like',
                         identifier: post.id)
  end

  def respond_to_vote
    respond_to do |format|
      format.html { redirect_back fallback_location: root_url }
      format.js
    end
  end
end
