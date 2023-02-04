class NotificationsController < ApplicationController
  before_action :require_login, only: %i[checked]

  def checked
    notification = current_user.notifications.find(params[:id])
    notification.read! if notification.unread?
    redirect_to notification.redirect_path
  end
  
  def index
    @post_image = PostImage.all
    @notifications = current_user.passive_notifications.page(params[:page]).per(10)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end 
  end
end
