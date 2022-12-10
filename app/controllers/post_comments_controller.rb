class PostCommentsController < ApplicationController
  def create
    @post_image = PostImage.find(params[:post_image_id])
    @comment = PostComment.new(post_comment_params)
    @post_image = @comment.post_image
    if @comment.save
      @post_image.create_notification_comment!(current_user, @comment.id)
      flash.now[:notice] = "コメントしました。"
      render :create
    else
      render :error
    end
  end
  
  
  def destroy
    @post_image = PostImage.find(params[:post_image_id])
    PostComment.find(params[:id]).destroy
    flash.now[:notice] = "コメントを削除しました。"
    render :destroy
  end
  
  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
