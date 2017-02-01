class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy, :like,
                                   :unlike]
  before_action :authenticate_user!
  before_action :redirect_if_not_owner, only: [:edit, :update, :destroy]

  def index
    @comment = Comment.new
    @posts = Post.all.order('created_at DESC').page(params[:page]).per(3)
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
    respond_to do |format|
      format.html { redirect_back fallback_location: root_url }
      format.js
    end
  end

  def unlike
    @post.unliked_by current_user
    respond_to do |format|
      format.html { redirect_back fallback_location: root_url }
      format.js
    end
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
end
