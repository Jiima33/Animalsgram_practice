class Tag < ApplicationRecord
  has_many :post_image_tag_relations, dependent: :destroy
  has_many :post_images, through: :post_image_tag_relations, dependent: :destroy
end
