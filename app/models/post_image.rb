class PostImage < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :PostImage_tag_relations, dependent: :destroy
  has_many :tags, through: :PostImage_tag_relations, dependent: :destroy
  
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
  
  def create_notification_favorite(current_user)
    notification = current_user.active_notifications.new(post_image_id: id, visited_id: user_id, action: 'favorite')
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
  
  def create_notification_comment(current_user)
    notification = current_user.active_notifications.new(post_image_id: id, visited_id: user_id, action: 'comment')
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end 
