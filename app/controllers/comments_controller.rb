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
    @commentable = find_commentable
    @comment = Comment.find(params[:id])
    user = @comment.user
    user.cc -= 10
    if @comment.destroy && user.save
      flash[:notice] = "Comment deleted"
      redirect_to [@commentable]
    else
      redirect_to [@commentable]
    end
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