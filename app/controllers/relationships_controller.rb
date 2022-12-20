class RelationshipsController < ApplicationController
  
  before_action :set_user
  
  def create
    following = current_user.follow(@user)
    if following.save
      flash[:success] = 'フォローしました'
      redirect_to @user
    else 
      flash.now[:alert] = 'フォローに失敗しました'
      redirect_to @user
    end
  end
    
  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      flash[:success] = 'フォローを外しました'
      redirect_to @user
    else
      flash.now[:alert] = 'フォローを外せませんでした'
      redirect_to @user
    end
  end
  
  private
  def set_user
    @user = User.find(params[:relationship][:follow_id])
  end
  
  
end