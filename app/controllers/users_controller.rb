class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.page(params[:page])
    @relationship = current_user.relationships.find_by(follow_id: @user.id)
    @set_relationship = current_user.relationships.new
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(current_user)
  end 
  
  private
  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
