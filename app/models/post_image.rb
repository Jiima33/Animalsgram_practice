class PostImage < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  
  validates :image, presence: true
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
 
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/noimage.png')
      image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
    end
    image
  end
  
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      post_image_id: id,
      visited_id: user_id,
      action: "favorite"
      )
      notification.save if notification.valid?
  end
  
  def create_notification_comment!(current_user, post_comment_id)
    temp_ids = PostComment.select(:user_id).where(post_image_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, post_comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, post_comment_id, user_id) if temp_ids.blank?
  end
  
  def save_notification_comment!(current_user, post_comment_id, visited_id)
    notification = current_user.active_notifications.new(
      post_image_id: id,
      post_comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
      )
      if notification.visiter_id == notification.visited_id
        notification.checked = true
      end 
      notification.save if notification.valid?
  end 
end
