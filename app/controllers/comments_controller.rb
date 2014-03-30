class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    user = current_user
    user.cc += 10
    if @comment.save && user.save
      flash[:notice] = "Comment added"
      redirect_to root_path
    end
  end


  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(
      :user_id,
      :content,
      :commentable_id,
      :commentable_type
    )
  end

end