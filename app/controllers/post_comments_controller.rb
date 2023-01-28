class PostCommentsController < ApplicationController
  def create
    @post_image = PostImage.find(params[:post_image_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.post_image_id = @post_image.id
    if @post_comment.save
      flash.now[:notice] = 'コメントを投稿しました'
      render :post_comments  #render先にjsファイルを指定
    else
      render :error
    end
  end

  def destroy
    PostComment.find_by(id: params[:id], post_image_id: params[:post_image_id]).destroy
    flash.now[:alert] = '投稿を削除しました'
    #renderしたときに@postのデータがないので@postを定義
    @post_image = PostImage.find(params[:post_image_id])  
    render :post_comments  #render先にjsファイルを指定
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
