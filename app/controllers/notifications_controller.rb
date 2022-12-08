class NotificationsController < ApplicationController
  def index
    @post_image = PostImage.all
    @notifications = current_user.passive_notifications.page(params[:page]).per(10)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end 
  end
end
