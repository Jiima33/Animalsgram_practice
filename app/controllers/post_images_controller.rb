class PostImagesController < ApplicationController
  def new
    @post_image = PostImage.new
  end 
  
  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    if @post_image.save
      redirect_to post_images_path
    else
      render :new
    end
  end
  
  def index
    @post_images = PostImage.page(params[:page])
  end
  
  def show
    @post_image = PostImage.find(params[:id])
    @comments = @post_image.post_comments  #投稿詳細に関連付けてあるコメントを全取得
    @comment = current_user.post_comments.new  #投稿詳細画面でコメントの投稿を行うので、formのパラメータ用にCommentオブジェクトを取得
    @user = User.find(params[:id])
  end
  
  def destroy
    @post_image= PostImage.find(params[:id])
    @post_image.destroy
    redirect_to post_images_path
  end
  
  private
  def post_image_params
    params.require(:post_image).permit(:image, :caption, tag_ids: [])
  end
end
