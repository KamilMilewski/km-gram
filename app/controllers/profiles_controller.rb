class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user_by_name, only: [:show, :edit, :update]
  before_action :redirect_if_not_owner, only: [:edit, :update]

  def show
    @posts = @user.posts.order('created_at DESC').page(params[:page]).per(3)
    @comment = Comment.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit; end

  def update
    if @user.update(profile_params)
      flash[:success] = 'Profile successfully updated.'
      redirect_to profile_path(@user.name)
    else
      flash.now[:warning] = 'Could not update profile.'
      render 'edit'
    end
  end

  private

  def find_user_by_name
    @user = User.find_by(name: params[:name])
  end

  def profile_params
    params.require(:user).permit(:bio, :avatar)
  end

  def redirect_if_not_owner
    return unless current_user.id != @user.id
    flash[:danger] = "That profile dosen't belong to you!"
    redirect_to root_path
  end
end
