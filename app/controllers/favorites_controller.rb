class FavoritesController < ApplicationController
  before_action :set_favorite
  
  def create
    favorite = current_user.favorites.new(post_image_id: @post_image.id)
    favorite.save
    @post_image.create_notification_favorite(current_user)
   redirect_to post_image_path(@post_image)
  end 
  
  def destroy
    post_image = PostImage.find(params[:post_image_id])
    favorite = current_user.favorites.find_by(post_image_id:post_image.id)
    favorite.destroy
    redirect_to post_image_path(@post_image)
  end
  
  private
  def set_favorite
    @post_image = PostImage.find(params[:post_image_id])
  end 
end
