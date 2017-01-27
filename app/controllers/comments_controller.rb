class CommentsController < ApplicationController
  before_action :find_comment, only: [:destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_back fallback_location: root_url
    else
      flash[:danger] = 'Could not create comment.'
      redirect_to root_path
    end
  end

  def destroy
    if current_user.id != @comment.user_id
      flash[:danger] = "You can't delete foreign comments."
    elsif @comment.destroy
      flash[:success] = 'Comment deleted.'
    else
      flash[:danger] = 'Could not delete comment.'
    end
    redirect_back fallback_location: root_url
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end
end
