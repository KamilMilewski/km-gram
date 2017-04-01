class RelationshipsController < ApplicationController
  def follow_user
    @user = User.find_by(name: params[:user_name])
    current_user.follow(@user)
    respond_to do |format|
      format.js
      format.html { redirect_back fallback_location: root_url }
    end
  end

  def unfollow_user
    @user = User.find_by(name: params[:user_name])
    current_user.unfollow(@user)
    respond_to do |format|
      format.js
      format.html { redirect_back fallback_location: root_url }
    end
  end
end
