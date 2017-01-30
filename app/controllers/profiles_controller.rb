class ProfilesController < ApplicationController
  def show
    @user = User.find_by(name: params[:name])
    @posts = @user.posts.order('created_at DESC').page(params[:page]).per(3)
    @comment = Comment.new
  end

  def edit; end
end
