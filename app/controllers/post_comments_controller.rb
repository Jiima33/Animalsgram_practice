class PostCommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @post_image = @comment.post_image
    if @comment.save
      @post_image.create_notification_comment!(current_user, @comment.id)
      redirect_back(fallback_location: post_image_path, notice: '投稿しました')
    else
      redirect_back(fallback_location: post_image_path, notice: '投稿に失敗しました')
    end
  end
  
  
  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_image_path(params[:post_image_id])
  end
  
  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
