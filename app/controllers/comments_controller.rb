class CommentsController < ApplicationController
  before_action :find_comment, only: [:destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      respond
    else
      flash[:danger] = 'Could not create comment.'
      redirect_to root_path
    end
  end

  def destroy
    if current_user.id != @comment.user_id
      flash[:danger] = "You can't delete foreign comments."
      redirect_back fallback_location: root_url
    elsif @comment.destroy
      respond
    else
      flash[:danger] = 'Could not delete comment.'
      redirect_back fallback_location: root_url
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def respond
    respond_to do |format|
      format.html { redirect_back fallback_location: root_url }
      format.js
    end
  end
end