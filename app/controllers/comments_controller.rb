class CommentsController < ApplicationController

  def create
    @commentable = find_commentable
    @comment = Comment.new(comment_params)
    user = current_user
    user.cc += 10
    if @comment.save && user.save
      flash[:notice] = "Comment added"
    end
    redirect_to [@commentable]
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

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

end